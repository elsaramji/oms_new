import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oms_new/core/database/daos/consultation_draft_dao.dart';
import 'package:oms_new/core/database/daos/queue_dao.dart';
import 'package:oms_new/features/clinical_consultation/data/datasources/simulated_ai_scribe_data_source.dart';
import 'package:oms_new/features/clinical_consultation/data/models/consultation_draft_model.dart';
import 'package:oms_new/features/clinical_consultation/data/repositories/consultation_repository_impl.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/ai_draft_note_entity.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/prescription_entity.dart';

class MockConsultationDraftDao extends Mock implements ConsultationDraftDao {}
class MockQueueDao extends Mock implements QueueDao {}
class MockSimulatedAiScribeDataSource extends Mock implements SimulatedAiScribeDataSource {}

void main() {
  late MockConsultationDraftDao mockDraftDao;
  late MockQueueDao mockQueueDao;
  late MockSimulatedAiScribeDataSource mockScribeDataSource;
  late ConsultationRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(
      ConsultationDraftModel(
        id: '',
        patientId: '',
        updatedAt: DateTime.now(),
      ).toCompanion(),
    );
  });

  setUp(() {
    mockDraftDao = MockConsultationDraftDao();
    mockQueueDao = MockQueueDao();
    mockScribeDataSource = MockSimulatedAiScribeDataSource();

    repository = ConsultationRepositoryImpl(
      draftDao: mockDraftDao,
      queueDao: mockQueueDao,
      scribeDataSource: mockScribeDataSource,
    );
  });

  final tAiDraft = ConsultationDraftModel(
    id: 'draft-ai-1',
    patientId: 'pat-1',
    subjective: 'Burning stomach pain',
    objective: 'Epigastric tenderness',
    assessment: 'Dyspepsia',
    plan: 'Omeprazole 20mg',
    prescriptions: const [
      PrescriptionEntity(
        id: 'rx-1',
        medicationName: 'Omeprazole',
        dosage: '20mg',
        frequency: 'OD',
        duration: '14 days',
      ),
    ],
    reviewStatus: DraftReviewStatus.draft,
    doctorApproved: false,
    isAiGenerated: true,
    updatedAt: DateTime(2026, 11, 15),
  );

  group('ConsultationRepositoryImpl', () {
    test('generateSimulatedAiScribe generates SOAP and caches in Drift DAO', () async {
      when(() => mockScribeDataSource.generateSoapDraft('pat-1'))
          .thenAnswer((_) async => tAiDraft);
      when(() => mockDraftDao.insertOrUpdateDraft(any()))
          .thenAnswer((_) async => 1);

      final result = await repository.generateSimulatedAiScribe('pat-1');

      expect(result, equals(Right(tAiDraft)));
      verify(() => mockScribeDataSource.generateSoapDraft('pat-1')).called(1);
      verify(() => mockDraftDao.insertOrUpdateDraft(any())).called(1);
    });

    test('saveDraft writes draft to local Drift DAO for offline resiliency', () async {
      when(() => mockDraftDao.insertOrUpdateDraft(any()))
          .thenAnswer((_) async => 1);

      final result = await repository.saveDraft(tAiDraft);

      expect(result, equals(const Right(unit)));
      verify(() => mockDraftDao.insertOrUpdateDraft(any())).called(1);
    });

    test('commitConsultation generates QR secured payload and marks queue item completed', () async {
      when(() => mockQueueDao.getWaitingQueue()).thenAnswer((_) async => []);
      when(() => mockDraftDao.deleteDraftByPatientId('pat-1')).thenAnswer((_) async => 1);

      final result = await repository.commitConsultation(
        draft: tAiDraft,
        patientName: 'Kareem Adel',
        doctorName: 'Dr. Mohamed Mostafa',
      );

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Should succeed'),
        (qrEntity) {
          expect(qrEntity.verificationHash, isNotEmpty);
          expect(qrEntity.qrPayload, contains('https://oms.clinic/verify/rx'));
          expect(qrEntity.patientName, equals('Kareem Adel'));
          expect(qrEntity.doctorName, equals('Dr. Mohamed Mostafa'));
        },
      );
      verify(() => mockDraftDao.deleteDraftByPatientId('pat-1')).called(1);
    });
  });
}
