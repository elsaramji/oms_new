import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:oms_new/core/database/app_database.dart';
import 'package:oms_new/core/database/daos/consultation_draft_dao.dart';
import 'package:oms_new/core/database/daos/patient_dao.dart';
import 'package:oms_new/core/database/daos/queue_dao.dart';
import 'package:oms_new/core/network/dio_client.dart';
import 'package:oms_new/core/network/network_info.dart';
import 'package:oms_new/features/assistant_intake/data/datasources/intake_local_data_source.dart';
import 'package:oms_new/features/assistant_intake/data/repositories/intake_repository_impl.dart';
import 'package:oms_new/features/assistant_intake/domain/repositories/intake_repository.dart';
import 'package:oms_new/features/assistant_intake/domain/usecases/forward_to_queue_usecase.dart';
import 'package:oms_new/features/assistant_intake/domain/usecases/register_patient_usecase.dart';
import 'package:oms_new/features/assistant_intake/domain/usecases/search_patient_usecase.dart';
import 'package:oms_new/features/assistant_intake/presentation/cubit/intake_cubit.dart';
import 'package:oms_new/features/auth/data/datasources/auth_data_source.dart';
import 'package:oms_new/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:oms_new/features/auth/domain/repositories/auth_repository.dart';
import 'package:oms_new/features/auth/domain/usecases/login_usecase.dart';
import 'package:oms_new/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:oms_new/features/clinical_consultation/data/datasources/simulated_ai_scribe_data_source.dart';
import 'package:oms_new/features/clinical_consultation/data/repositories/consultation_repository_impl.dart';
import 'package:oms_new/features/clinical_consultation/domain/repositories/consultation_repository.dart';
import 'package:oms_new/features/clinical_consultation/domain/usecases/commit_consultation_usecase.dart';
import 'package:oms_new/features/clinical_consultation/presentation/cubit/consultation_cubit.dart';
import 'package:oms_new/features/doctor_queue_ehr/data/datasources/doctor_queue_data_source.dart';
import 'package:oms_new/features/doctor_queue_ehr/data/repositories/doctor_queue_repository_impl.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/repositories/doctor_queue_repository.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/usecases/get_longitudinal_ehr_usecase.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/usecases/watch_live_queue_usecase.dart';
import 'package:oms_new/features/doctor_queue_ehr/presentation/cubit/doctor_queue_cubit.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies({String? environment}) async {
  getIt.init(environment: environment);
}

@module
abstract class CoreModule {
  @lazySingleton
  Connectivity get connectivity => Connectivity();

  @lazySingleton
  NetworkInfo networkInfo(Connectivity connectivity) =>
      NetworkInfoImpl(connectivity);

  @singleton
  AppDatabase get appDatabase => AppDatabase();

  @lazySingleton
  PatientDao patientDao(AppDatabase db) => db.patientDao;

  @lazySingleton
  QueueDao queueDao(AppDatabase db) => db.queueDao;

  @lazySingleton
  ConsultationDraftDao consultationDraftDao(AppDatabase db) =>
      db.consultationDraftDao;

  @lazySingleton
  Dio get dio => createDioClient();

  // Auth
  @lazySingleton
  AuthDataSource get authDataSource => MockAuthDataSource();

  @lazySingleton
  AuthRepository authRepository(AuthDataSource ds) => AuthRepositoryImpl(ds);

  @lazySingleton
  LoginUseCase loginUseCase(AuthRepository repo) => LoginUseCase(repo);

  @injectable
  AuthCubit authCubit(LoginUseCase luc, AuthRepository repo) =>
      AuthCubit(loginUseCase: luc, authRepository: repo);

  // Intake
  @lazySingleton
  IntakeLocalDataSource intakeLocalDataSource(
          PatientDao patientDao, QueueDao queueDao) =>
      IntakeLocalDataSourceImpl(patientDao: patientDao, queueDao: queueDao);

  @lazySingleton
  IntakeRepository intakeRepository(IntakeLocalDataSource ds) =>
      IntakeRepositoryImpl(ds);

  @lazySingleton
  SearchPatientUseCase searchPatientUseCase(IntakeRepository repo) =>
      SearchPatientUseCase(repo);

  @lazySingleton
  RegisterPatientUseCase registerPatientUseCase(IntakeRepository repo) =>
      RegisterPatientUseCase(repo);

  @lazySingleton
  ForwardToQueueUseCase forwardToQueueUseCase(IntakeRepository repo) =>
      ForwardToQueueUseCase(repo);

  @injectable
  IntakeCubit intakeCubit(
    SearchPatientUseCase search,
    RegisterPatientUseCase register,
    ForwardToQueueUseCase forward,
  ) =>
      IntakeCubit(
        searchPatientUseCase: search,
        registerPatientUseCase: register,
        forwardToQueueUseCase: forward,
      );

  // Doctor Queue & EHR
  @lazySingleton
  DoctorQueueDataSource doctorQueueDataSource(QueueDao queueDao) =>
      DoctorQueueDataSourceImpl(queueDao);

  @lazySingleton
  DoctorQueueRepository doctorQueueRepository(DoctorQueueDataSource ds) =>
      DoctorQueueRepositoryImpl(ds);

  @lazySingleton
  WatchLiveQueueUseCase watchLiveQueueUseCase(DoctorQueueRepository repo) =>
      WatchLiveQueueUseCase(repo);

  @lazySingleton
  GetLongitudinalEhrUseCase getLongitudinalEhrUseCase(
          DoctorQueueRepository repo) =>
      GetLongitudinalEhrUseCase(repo);

  @injectable
  DoctorQueueCubit doctorQueueCubit(
    WatchLiveQueueUseCase watchQueue,
    GetLongitudinalEhrUseCase getEhr,
    DoctorQueueRepository repo,
  ) =>
      DoctorQueueCubit(
        watchLiveQueueUseCase: watchQueue,
        getLongitudinalEhrUseCase: getEhr,
        repository: repo,
      );

  // Clinical Consultation
  @lazySingleton
  SimulatedAiScribeDataSource get simulatedAiScribeDataSource =>
      SimulatedAiScribeDataSourceImpl();

  @lazySingleton
  ConsultationRepository consultationRepository(
    ConsultationDraftDao draftDao,
    QueueDao queueDao,
    SimulatedAiScribeDataSource scribeDataSource,
  ) =>
      ConsultationRepositoryImpl(
        draftDao: draftDao,
        queueDao: queueDao,
        scribeDataSource: scribeDataSource,
      );

  @lazySingleton
  CommitConsultationUseCase commitConsultationUseCase(
          ConsultationRepository repo) =>
      CommitConsultationUseCase(repo);

  @injectable
  ConsultationCubit consultationCubit(
    ConsultationRepository repo,
    CommitConsultationUseCase commitUseCase,
  ) =>
      ConsultationCubit(
        repository: repo,
        commitConsultationUseCase: commitUseCase,
      );
}
