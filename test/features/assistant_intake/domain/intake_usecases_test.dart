import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oms_new/core/error/failures.dart';
import 'package:oms_new/features/assistant_intake/domain/entities/intake_vitals_entity.dart';
import 'package:oms_new/features/assistant_intake/domain/entities/patient_summary_entity.dart';
import 'package:oms_new/features/assistant_intake/domain/repositories/intake_repository.dart';
import 'package:oms_new/features/assistant_intake/domain/usecases/forward_to_queue_usecase.dart';
import 'package:oms_new/features/assistant_intake/domain/usecases/register_patient_usecase.dart';
import 'package:oms_new/features/assistant_intake/domain/usecases/search_patient_usecase.dart';

class MockIntakeRepository extends Mock implements IntakeRepository {}

void main() {
  late MockIntakeRepository mockRepository;
  late SearchPatientUseCase searchPatientUseCase;
  late RegisterPatientUseCase registerPatientUseCase;
  late ForwardToQueueUseCase forwardToQueueUseCase;

  setUp(() {
    mockRepository = MockIntakeRepository();
    searchPatientUseCase = SearchPatientUseCase(mockRepository);
    registerPatientUseCase = RegisterPatientUseCase(mockRepository);
    forwardToQueueUseCase = ForwardToQueueUseCase(mockRepository);
  });

  const tPatient = PatientSummaryEntity(
    id: 'pat-101',
    nationalId: '29810101234567',
    fullName: 'Youssef El-Sayed',
    phoneNumber: '+201112223344',
    age: 28,
    gender: 'Male',
    bloodType: 'O+',
  );

  const tValidVitals = IntakeVitalsEntity(
    systolicBp: 120,
    diastolicBp: 80,
    pulseRate: 75,
    temperature: 37.0,
    oxygenSaturation: 98.0,
    weight: 70.0,
    height: 175.0,
  );

  const tInvalidVitals = IntakeVitalsEntity(
    systolicBp: 350, // invalid physiological limit
    diastolicBp: 80,
    pulseRate: 75,
    temperature: 37.0,
    oxygenSaturation: 98.0,
    weight: 70.0,
    height: 175.0,
  );

  group('SearchPatientUseCase', () {
    test('returns found patient demographic summary', () async {
      when(() => mockRepository.searchPatient('29810101234567'))
          .thenAnswer((_) async => const Right(Some(tPatient)));

      final result = await searchPatientUseCase('29810101234567');

      expect(result, equals(const Right(Some(tPatient))));
      verify(() => mockRepository.searchPatient('29810101234567')).called(1);
    });

    test('returns error when identifier is empty', () async {
      final result = await searchPatientUseCase('   ');
      expect(result.isLeft(), isTrue);
    });
  });

  group('RegisterPatientUseCase', () {
    test('registers valid patient demographic record', () async {
      when(() => mockRepository.registerPatient(tPatient))
          .thenAnswer((_) async => const Right(tPatient));

      final result = await registerPatientUseCase(tPatient);

      expect(result, equals(const Right(tPatient)));
      verify(() => mockRepository.registerPatient(tPatient)).called(1);
    });

    test('rejects registration when national ID is not 14 digits', () async {
      const invalidPatient = PatientSummaryEntity(
        id: 'p-1',
        nationalId: '12345', // Invalid
        fullName: 'Short ID',
        phoneNumber: '0100',
        age: 20,
        gender: 'Male',
        bloodType: 'B+',
      );

      final result = await registerPatientUseCase(invalidPatient);
      expect(result.isLeft(), isTrue);
    });
  });

  group('ForwardToQueueUseCase', () {
    test('forwards patient with valid vitals and computes BMI', () async {
      expect(tValidVitals.bmi, equals(22.9));

      when(() => mockRepository.forwardToQueue(
            patient: tPatient,
            vitals: tValidVitals,
            priority: 'normal',
          )).thenAnswer((_) async => const Right('queue-item-001'));

      final result = await forwardToQueueUseCase(
        const ForwardToQueueParams(
          patient: tPatient,
          vitals: tValidVitals,
        ),
      );

      expect(result, equals(const Right('queue-item-001')));
    });

    test('rejects forwarding when vitals violate physiological safety limits', () async {
      expect(tInvalidVitals.isValid, isFalse);

      final result = await forwardToQueueUseCase(
        const ForwardToQueueParams(
          patient: tPatient,
          vitals: tInvalidVitals,
        ),
      );

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<ClinicalSafetyFailure>()),
        (_) => fail('Should have failed'),
      );
      verifyZeroInteractions(mockRepository);
    });
  });
}
