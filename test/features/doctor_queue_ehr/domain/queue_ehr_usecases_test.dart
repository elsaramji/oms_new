import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oms_new/core/error/failures.dart';
import 'package:oms_new/features/assistant_intake/domain/entities/intake_vitals_entity.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/entities/allergy_alert_entity.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/entities/ehr_timeline_entity.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/entities/medical_record_entity.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/entities/queue_patient_entity.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/repositories/doctor_queue_repository.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/usecases/get_longitudinal_ehr_usecase.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/usecases/watch_live_queue_usecase.dart';

class MockDoctorQueueRepository extends Mock implements DoctorQueueRepository {}

void main() {
  late MockDoctorQueueRepository mockRepository;
  late WatchLiveQueueUseCase watchLiveQueueUseCase;
  late GetLongitudinalEhrUseCase getLongitudinalEhrUseCase;

  setUp(() {
    mockRepository = MockDoctorQueueRepository();
    watchLiveQueueUseCase = WatchLiveQueueUseCase(mockRepository);
    getLongitudinalEhrUseCase = GetLongitudinalEhrUseCase(mockRepository);
  });

  final tQueuePatient = QueuePatientEntity(
    id: 'q-101',
    patientId: 'pat-101',
    patientName: 'Kareem Adel',
    queueNumber: 1,
    status: 'waiting',
    priority: 'urgent',
    forwardedAt: DateTime(2026, 11, 15, 10, 0),
    vitals: const IntakeVitalsEntity(
      systolicBp: 140,
      diastolicBp: 90,
      pulseRate: 88,
      temperature: 38.2,
      oxygenSaturation: 97.0,
      weight: 80.0,
      height: 180.0,
    ),
  );

  final tEhrTimeline = EhrTimelineEntity(
    patientId: 'pat-101',
    allergies: const [
      AllergyAlertEntity(
        allergen: 'Penicillin',
        severity: 'Severe',
        reaction: 'Anaphylaxis',
      ),
    ],
    chronicConditions: const ['Type 2 Diabetes', 'Hypertension'],
    records: [
      MedicalRecordEntity(
        visitId: 'v-1',
        visitDate: DateTime(2026, 10, 1),
        attendingDoctor: 'Dr. Tarek',
        chiefComplaint: 'Routine follow-up',
        diagnosis: 'Well-controlled diabetes',
        prescriptions: const ['Metformin 500mg BID'],
      ),
    ],
  );

  group('WatchLiveQueueUseCase', () {
    test('emits stream of queue patients from repository', () {
      when(() => mockRepository.watchWaitingQueue())
          .thenAnswer((_) => Stream.value([tQueuePatient]));

      final result = watchLiveQueueUseCase();

      expect(result, emits([tQueuePatient]));
      verify(() => mockRepository.watchWaitingQueue()).called(1);
    });
  });

  group('GetLongitudinalEhrUseCase', () {
    test('returns EhrTimelineEntity with severe allergy alerts', () async {
      when(() => mockRepository.getLongitudinalEhr('pat-101'))
          .thenAnswer((_) async => Right(tEhrTimeline));

      final result = await getLongitudinalEhrUseCase('pat-101');

      expect(result, equals(Right(tEhrTimeline)));
      result.fold(
        (_) => fail('Should succeed'),
        (timeline) {
          expect(timeline.hasSevereAllergies, isTrue);
          expect(timeline.chronicConditions, contains('Type 2 Diabetes'));
          expect(timeline.records.length, equals(1));
        },
      );
    });

    test('returns failure when patientId is blank', () async {
      final result = await getLongitudinalEhrUseCase('');
      expect(result.isLeft(), isTrue);
    });
  });
}
