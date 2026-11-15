import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/entities/ehr_timeline_entity.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/entities/queue_patient_entity.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/repositories/doctor_queue_repository.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/usecases/get_longitudinal_ehr_usecase.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/usecases/watch_live_queue_usecase.dart';
import 'package:oms_new/features/doctor_queue_ehr/presentation/cubit/doctor_queue_cubit.dart';
import 'package:oms_new/features/doctor_queue_ehr/presentation/cubit/doctor_queue_state.dart';

class MockWatchLiveQueueUseCase extends Mock implements WatchLiveQueueUseCase {}
class MockGetLongitudinalEhrUseCase extends Mock implements GetLongitudinalEhrUseCase {}
class MockDoctorQueueRepository extends Mock implements DoctorQueueRepository {}

void main() {
  late MockWatchLiveQueueUseCase mockWatchQueue;
  late MockGetLongitudinalEhrUseCase mockGetEhr;
  late MockDoctorQueueRepository mockRepository;
  late DoctorQueueCubit cubit;

  setUp(() {
    mockWatchQueue = MockWatchLiveQueueUseCase();
    mockGetEhr = MockGetLongitudinalEhrUseCase();
    mockRepository = MockDoctorQueueRepository();

    cubit = DoctorQueueCubit(
      watchLiveQueueUseCase: mockWatchQueue,
      getLongitudinalEhrUseCase: mockGetEhr,
      repository: mockRepository,
    );
  });

  tearDown(() => cubit.close());

  final tQueuePatient = QueuePatientEntity(
    id: 'q-1',
    patientId: 'pat-1',
    patientName: 'Mohamed Aly',
    queueNumber: 1,
    status: 'waiting',
    priority: 'normal',
    forwardedAt: DateTime(2026, 11, 15),
  );

  const tEhr = EhrTimelineEntity(
    patientId: 'pat-1',
    allergies: [],
    chronicConditions: [],
    records: [],
  );

  test('initial state is DoctorQueueInitial', () {
    expect(cubit.state, equals(const DoctorQueueInitial()));
  });

  blocTest<DoctorQueueCubit, DoctorQueueState>(
    'startQueueSubscription emits [DoctorQueueLoading, DoctorQueueLoaded]',
    build: () {
      when(() => mockWatchQueue())
          .thenAnswer((_) => Stream.value([tQueuePatient]));
      return cubit;
    },
    act: (cubit) => cubit.startQueueSubscription(),
    expect: () => [
      const DoctorQueueLoading(),
      DoctorQueueLoaded(queuePatients: [tQueuePatient]),
    ],
  );

  blocTest<DoctorQueueCubit, DoctorQueueState>(
    'selectPatient transitions queue status and loads EHR timeline',
    seed: () => DoctorQueueLoaded(queuePatients: [tQueuePatient]),
    build: () {
      when(() => mockRepository.updateQueueStatus('q-1', 'inConsultation'))
          .thenAnswer((_) async => const Right(unit));
      when(() => mockGetEhr('pat-1'))
          .thenAnswer((_) async => const Right(tEhr));
      return cubit;
    },
    act: (cubit) => cubit.selectPatient(tQueuePatient),
    expect: () => [
      DoctorQueueLoaded(
        queuePatients: [tQueuePatient],
        selectedPatient: tQueuePatient,
        isLoadingEhr: true,
      ),
      DoctorQueueLoaded(
        queuePatients: [tQueuePatient],
        selectedPatient: tQueuePatient,
        selectedPatientEhr: tEhr,
        isLoadingEhr: false,
      ),
    ],
  );
}
