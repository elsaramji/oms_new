import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oms_new/core/error/failures.dart';
import 'package:oms_new/features/doctor_queue_ehr/data/datasources/doctor_queue_data_source.dart';
import 'package:oms_new/features/doctor_queue_ehr/data/models/ehr_models.dart';
import 'package:oms_new/features/doctor_queue_ehr/data/models/queue_patient_model.dart';
import 'package:oms_new/features/doctor_queue_ehr/data/repositories/doctor_queue_repository_impl.dart';

class MockDoctorQueueDataSource extends Mock implements DoctorQueueDataSource {}

void main() {
  late MockDoctorQueueDataSource mockDataSource;
  late DoctorQueueRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockDoctorQueueDataSource();
    repository = DoctorQueueRepositoryImpl(mockDataSource);
  });

  final tQueuePatient = QueuePatientModel(
    id: 'q-1',
    patientId: 'pat-1',
    patientName: 'Ali Hassan',
    queueNumber: 1,
    status: 'waiting',
    priority: 'normal',
    forwardedAt: DateTime(2026, 11, 15),
  );

  final tEhr = EhrTimelineModel(
    patientId: 'pat-1',
    allergies: const [
      AllergyAlertModel(
        allergen: 'Penicillin',
        severity: 'Severe',
        reaction: 'Anaphylaxis',
      ),
    ],
    chronicConditions: const ['Diabetes'],
    records: const [],
  );

  group('DoctorQueueRepositoryImpl', () {
    test('watchWaitingQueue maps stream from data source', () {
      when(() => mockDataSource.watchWaitingQueue())
          .thenAnswer((_) => Stream.value([tQueuePatient]));

      final stream = repository.watchWaitingQueue();

      expect(stream, emits([tQueuePatient]));
    });

    test('getLongitudinalEhr returns Right(EhrTimelineEntity)', () async {
      when(() => mockDataSource.getPatientEhr('pat-1'))
          .thenAnswer((_) async => tEhr);

      final result = await repository.getLongitudinalEhr('pat-1');

      expect(result, equals(Right(tEhr)));
    });

    test('updateQueueStatus returns Right(unit) on success', () async {
      when(() => mockDataSource.updateQueueStatus('q-1', 'inConsultation'))
          .thenAnswer((_) async {});

      final result = await repository.updateQueueStatus('q-1', 'inConsultation');

      expect(result, equals(const Right(unit)));
    });
  });
}
