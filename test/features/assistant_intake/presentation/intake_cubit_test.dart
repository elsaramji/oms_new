import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oms_new/core/error/failures.dart';
import 'package:oms_new/features/assistant_intake/domain/entities/intake_vitals_entity.dart';
import 'package:oms_new/features/assistant_intake/domain/entities/patient_summary_entity.dart';
import 'package:oms_new/features/assistant_intake/domain/usecases/forward_to_queue_usecase.dart';
import 'package:oms_new/features/assistant_intake/domain/usecases/register_patient_usecase.dart';
import 'package:oms_new/features/assistant_intake/domain/usecases/search_patient_usecase.dart';
import 'package:oms_new/features/assistant_intake/presentation/cubit/intake_cubit.dart';
import 'package:oms_new/features/assistant_intake/presentation/cubit/intake_state.dart';

class MockSearchPatientUseCase extends Mock implements SearchPatientUseCase {}
class MockRegisterPatientUseCase extends Mock implements RegisterPatientUseCase {}
class MockForwardToQueueUseCase extends Mock implements ForwardToQueueUseCase {}

void main() {
  late MockSearchPatientUseCase mockSearch;
  late MockRegisterPatientUseCase mockRegister;
  late MockForwardToQueueUseCase mockForward;
  late IntakeCubit cubit;

  setUpAll(() {
    registerFallbackValue(
      const PatientSummaryEntity(
        id: '',
        nationalId: '',
        fullName: '',
        phoneNumber: '',
        age: 0,
        gender: '',
        bloodType: '',
      ),
    );
    registerFallbackValue(
      const ForwardToQueueParams(
        patient: PatientSummaryEntity(
          id: '',
          nationalId: '',
          fullName: '',
          phoneNumber: '',
          age: 0,
          gender: '',
          bloodType: '',
        ),
        vitals: IntakeVitalsEntity(
          systolicBp: 0,
          diastolicBp: 0,
          pulseRate: 0,
          temperature: 0,
          oxygenSaturation: 0,
          weight: 0,
          height: 0,
        ),
      ),
    );
  });

  setUp(() {
    mockSearch = MockSearchPatientUseCase();
    mockRegister = MockRegisterPatientUseCase();
    mockForward = MockForwardToQueueUseCase();
    cubit = IntakeCubit(
      searchPatientUseCase: mockSearch,
      registerPatientUseCase: mockRegister,
      forwardToQueueUseCase: mockForward,
    );
  });

  tearDown(() => cubit.close());

  const tPatient = PatientSummaryEntity(
    id: 'pat-100',
    nationalId: '29501011234567',
    fullName: 'Sara Ahmed',
    phoneNumber: '+201011122233',
    age: 30,
    gender: 'Female',
    bloodType: 'B+',
  );

  const tVitals = IntakeVitalsEntity(
    systolicBp: 120,
    diastolicBp: 80,
    pulseRate: 72,
    temperature: 36.8,
    oxygenSaturation: 98.0,
    weight: 60.0,
    height: 165.0,
  );

  test('initial state is IntakeInitial', () {
    expect(cubit.state, equals(const IntakeInitial()));
  });

  blocTest<IntakeCubit, IntakeState>(
    'emits [IntakeLoading, PatientFound] when search finds existing patient',
    build: () {
      when(() => mockSearch('29501011234567'))
          .thenAnswer((_) async => const Right(Some(tPatient)));
      return cubit;
    },
    act: (cubit) => cubit.searchPatient('29501011234567'),
    expect: () => [
      const IntakeLoading(),
      const PatientFound(tPatient),
    ],
  );

  blocTest<IntakeCubit, IntakeState>(
    'emits [IntakeLoading, PatientNotFound] when search finds nothing',
    build: () {
      when(() => mockSearch('99999999999999'))
          .thenAnswer((_) async => const Right(None()));
      return cubit;
    },
    act: (cubit) => cubit.searchPatient('99999999999999'),
    expect: () => [
      const IntakeLoading(),
      const PatientNotFound('99999999999999'),
    ],
  );

  blocTest<IntakeCubit, IntakeState>(
    'emits [IntakeLoading, PatientRegistered] when registration succeeds',
    build: () {
      when(() => mockRegister(tPatient))
          .thenAnswer((_) async => const Right(tPatient));
      return cubit;
    },
    act: (cubit) => cubit.registerPatient(tPatient),
    expect: () => [
      const IntakeLoading(),
      const PatientRegistered(tPatient),
    ],
  );

  blocTest<IntakeCubit, IntakeState>(
    'emits [IntakeLoading, IntakeDispatchedToQueue] on queue forwarding',
    build: () {
      when(() => mockForward(any()))
          .thenAnswer((_) async => const Right('queue-item-456'));
      return cubit;
    },
    act: (cubit) => cubit.forwardToQueue(
      patient: tPatient,
      vitals: tVitals,
      priority: 'normal',
    ),
    expect: () => [
      const IntakeLoading(),
      const IntakeDispatchedToQueue(
        queueId: 'queue-item-456',
        patient: tPatient,
      ),
    ],
  );
}
