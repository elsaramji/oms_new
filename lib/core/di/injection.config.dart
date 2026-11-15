// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/assistant_intake/data/datasources/intake_local_data_source.dart'
    as _i213;
import '../../features/assistant_intake/domain/repositories/intake_repository.dart'
    as _i608;
import '../../features/assistant_intake/domain/usecases/forward_to_queue_usecase.dart'
    as _i708;
import '../../features/assistant_intake/domain/usecases/register_patient_usecase.dart'
    as _i757;
import '../../features/assistant_intake/domain/usecases/search_patient_usecase.dart'
    as _i73;
import '../../features/assistant_intake/presentation/cubit/intake_cubit.dart'
    as _i51;
import '../../features/auth/data/datasources/auth_data_source.dart' as _i970;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;
import '../../features/clinical_consultation/data/datasources/simulated_ai_scribe_data_source.dart'
    as _i366;
import '../../features/clinical_consultation/domain/repositories/consultation_repository.dart'
    as _i159;
import '../../features/clinical_consultation/domain/usecases/commit_consultation_usecase.dart'
    as _i855;
import '../../features/clinical_consultation/presentation/cubit/consultation_cubit.dart'
    as _i227;
import '../../features/doctor_queue_ehr/data/datasources/doctor_queue_data_source.dart'
    as _i381;
import '../../features/doctor_queue_ehr/domain/repositories/doctor_queue_repository.dart'
    as _i192;
import '../../features/doctor_queue_ehr/domain/usecases/get_longitudinal_ehr_usecase.dart'
    as _i749;
import '../../features/doctor_queue_ehr/domain/usecases/watch_live_queue_usecase.dart'
    as _i731;
import '../../features/doctor_queue_ehr/presentation/cubit/doctor_queue_cubit.dart'
    as _i513;
import '../database/app_database.dart' as _i982;
import '../database/daos/consultation_draft_dao.dart' as _i641;
import '../database/daos/patient_dao.dart' as _i875;
import '../database/daos/queue_dao.dart' as _i389;
import '../network/network_info.dart' as _i932;
import 'injection.dart' as _i464;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final coreModule = _$CoreModule();
    gh.singleton<_i982.AppDatabase>(() => coreModule.appDatabase);
    gh.lazySingleton<_i895.Connectivity>(() => coreModule.connectivity);
    gh.lazySingleton<_i361.Dio>(() => coreModule.dio);
    gh.lazySingleton<_i970.AuthDataSource>(() => coreModule.authDataSource);
    gh.lazySingleton<_i366.SimulatedAiScribeDataSource>(
      () => coreModule.simulatedAiScribeDataSource,
    );
    gh.lazySingleton<_i932.NetworkInfo>(
      () => coreModule.networkInfo(gh<_i895.Connectivity>()),
    );
    gh.lazySingleton<_i875.PatientDao>(
      () => coreModule.patientDao(gh<_i982.AppDatabase>()),
    );
    gh.lazySingleton<_i389.QueueDao>(
      () => coreModule.queueDao(gh<_i982.AppDatabase>()),
    );
    gh.lazySingleton<_i641.ConsultationDraftDao>(
      () => coreModule.consultationDraftDao(gh<_i982.AppDatabase>()),
    );
    gh.lazySingleton<_i381.DoctorQueueDataSource>(
      () => coreModule.doctorQueueDataSource(gh<_i389.QueueDao>()),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => coreModule.authRepository(gh<_i970.AuthDataSource>()),
    );
    gh.lazySingleton<_i213.IntakeLocalDataSource>(
      () => coreModule.intakeLocalDataSource(
        gh<_i875.PatientDao>(),
        gh<_i389.QueueDao>(),
      ),
    );
    gh.lazySingleton<_i192.DoctorQueueRepository>(
      () => coreModule.doctorQueueRepository(gh<_i381.DoctorQueueDataSource>()),
    );
    gh.lazySingleton<_i608.IntakeRepository>(
      () => coreModule.intakeRepository(gh<_i213.IntakeLocalDataSource>()),
    );
    gh.lazySingleton<_i73.SearchPatientUseCase>(
      () => coreModule.searchPatientUseCase(gh<_i608.IntakeRepository>()),
    );
    gh.lazySingleton<_i757.RegisterPatientUseCase>(
      () => coreModule.registerPatientUseCase(gh<_i608.IntakeRepository>()),
    );
    gh.lazySingleton<_i708.ForwardToQueueUseCase>(
      () => coreModule.forwardToQueueUseCase(gh<_i608.IntakeRepository>()),
    );
    gh.lazySingleton<_i159.ConsultationRepository>(
      () => coreModule.consultationRepository(
        gh<_i641.ConsultationDraftDao>(),
        gh<_i389.QueueDao>(),
        gh<_i366.SimulatedAiScribeDataSource>(),
      ),
    );
    gh.lazySingleton<_i188.LoginUseCase>(
      () => coreModule.loginUseCase(gh<_i787.AuthRepository>()),
    );
    gh.lazySingleton<_i731.WatchLiveQueueUseCase>(
      () => coreModule.watchLiveQueueUseCase(gh<_i192.DoctorQueueRepository>()),
    );
    gh.lazySingleton<_i749.GetLongitudinalEhrUseCase>(
      () => coreModule.getLongitudinalEhrUseCase(
        gh<_i192.DoctorQueueRepository>(),
      ),
    );
    gh.factory<_i51.IntakeCubit>(
      () => coreModule.intakeCubit(
        gh<_i73.SearchPatientUseCase>(),
        gh<_i757.RegisterPatientUseCase>(),
        gh<_i708.ForwardToQueueUseCase>(),
      ),
    );
    gh.factory<_i513.DoctorQueueCubit>(
      () => coreModule.doctorQueueCubit(
        gh<_i731.WatchLiveQueueUseCase>(),
        gh<_i749.GetLongitudinalEhrUseCase>(),
        gh<_i192.DoctorQueueRepository>(),
      ),
    );
    gh.lazySingleton<_i855.CommitConsultationUseCase>(
      () => coreModule.commitConsultationUseCase(
        gh<_i159.ConsultationRepository>(),
      ),
    );
    gh.factory<_i227.ConsultationCubit>(
      () => coreModule.consultationCubit(
        gh<_i159.ConsultationRepository>(),
        gh<_i855.CommitConsultationUseCase>(),
      ),
    );
    gh.factory<_i117.AuthCubit>(
      () => coreModule.authCubit(
        gh<_i188.LoginUseCase>(),
        gh<_i787.AuthRepository>(),
      ),
    );
    return this;
  }
}

class _$CoreModule extends _i464.CoreModule {}
