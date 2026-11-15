import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oms_new/core/error/failures.dart';
import 'package:oms_new/features/assistant_intake/data/datasources/intake_local_data_source.dart';
import 'package:oms_new/features/assistant_intake/data/models/intake_vitals_model.dart';
import 'package:oms_new/features/assistant_intake/data/models/patient_summary_model.dart';
import 'package:oms_new/features/assistant_intake/data/repositories/intake_repository_impl.dart';

class MockIntakeLocalDataSource extends Mock implements IntakeLocalDataSource {}

void main() {
  late MockIntakeLocalDataSource mockDataSource;
  late IntakeRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(
      const PatientSummaryModel(
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
      const IntakeVitalsModel(
        systolicBp: 0,
        diastolicBp: 0,
        pulseRate: 0,
        temperature: 0,
        oxygenSaturation: 0,
        weight: 0,
        height: 0,
      ),
    );
  });

  setUp(() {
    mockDataSource = MockIntakeLocalDataSource();
    repository = IntakeRepositoryImpl(mockDataSource);
  });

  const tPatientModel = PatientSummaryModel(
    id: 'pat-001',
    nationalId: '29001011234567',
    fullName: 'Mona Mahmoud',
    phoneNumber: '+201098765432',
    age: 34,
    gender: 'Female',
    bloodType: 'A+',
  );

  const tVitalsModel = IntakeVitalsModel(
    systolicBp: 118,
    diastolicBp: 78,
    pulseRate: 72,
    temperature: 36.8,
    oxygenSaturation: 99.0,
    weight: 65.0,
    height: 168.0,
  );

  group('IntakeRepositoryImpl', () {
    test('searchPatient returns Some(patient) when found', () async {
      when(() => mockDataSource.findPatientByIdentifier('29001011234567'))
          .thenAnswer((_) async => tPatientModel);

      final result = await repository.searchPatient('29001011234567');

      expect(result, equals(const Right(Some(tPatientModel))));
    });

    test('searchPatient returns None when patient does not exist', () async {
      when(() => mockDataSource.findPatientByIdentifier('unknown'))
          .thenAnswer((_) async => null);

      final result = await repository.searchPatient('unknown');

      expect(result, equals(const Right(None())));
    });

    test('registerPatient succeeds and stores record when not duplicate', () async {
      when(() => mockDataSource.findPatientByIdentifier(tPatientModel.nationalId))
          .thenAnswer((_) async => null);
      when(() => mockDataSource.savePatient(any()))
          .thenAnswer((_) async {});

      final result = await repository.registerPatient(tPatientModel);

      expect(result, equals(const Right(tPatientModel)));
      verify(() => mockDataSource.savePatient(any())).called(1);
    });

    test('registerPatient rejects duplicate national ID', () async {
      when(() => mockDataSource.findPatientByIdentifier(tPatientModel.nationalId))
          .thenAnswer((_) async => tPatientModel);

      final result = await repository.registerPatient(tPatientModel);

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure.message, contains('already registered')),
        (_) => fail('Should have failed'),
      );
    });

    test('forwardToQueue returns assigned queue identifier', () async {
      when(() => mockDataSource.enqueuePatient(
            patient: any(named: 'patient'),
            vitals: any(named: 'vitals'),
            priority: any(named: 'priority'),
          )).thenAnswer((_) async => 'queue-id-999');

      final result = await repository.forwardToQueue(
        patient: tPatientModel,
        vitals: tVitalsModel,
        priority: 'normal',
      );

      expect(result, equals(const Right('queue-id-999')));
    });
  });
}
