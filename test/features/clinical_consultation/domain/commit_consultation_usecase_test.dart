import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oms_new/core/error/exceptions.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/ai_draft_note_entity.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/prescription_entity.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/prescription_qr_entity.dart';
import 'package:oms_new/features/clinical_consultation/domain/repositories/consultation_repository.dart';
import 'package:oms_new/features/clinical_consultation/domain/usecases/commit_consultation_usecase.dart';

class MockConsultationRepository extends Mock implements ConsultationRepository {}

void main() {
  late MockConsultationRepository mockRepository;
  late CommitConsultationUseCase useCase;

  setUp(() {
    mockRepository = MockConsultationRepository();
    useCase = CommitConsultationUseCase(mockRepository);
  });

  final tUnapprovedDraft = AiDraftNoteEntity(
    id: 'draft-001',
    patientId: 'pat-100',
    subjective: 'Patient reports mild chest tightness',
    objective: 'BP 130/85, Pulse 80',
    assessment: 'Atypical chest pain',
    plan: 'ECG and observation',
    prescriptions: const [
      PrescriptionEntity(
        id: 'rx-1',
        medicationName: 'Aspirin',
        dosage: '81mg',
        frequency: 'OD',
        duration: '30 days',
      ),
    ],
    reviewStatus: DraftReviewStatus.draft,
    doctorApproved: false, // NOT APPROVED
    isAiGenerated: true,
    updatedAt: DateTime.now(),
  );

  final tApprovedDraft = tUnapprovedDraft.copyWith(
    doctorApproved: true,
    reviewStatus: DraftReviewStatus.approved,
  );

  final tPrescriptionQr = PrescriptionQrEntity(
    prescriptionId: 'rx-qr-123',
    patientId: 'pat-100',
    patientName: 'Ahmed Hassan',
    doctorName: 'Dr. Mohamed Mostafa',
    issuedAt: DateTime.now(),
    medications: tApprovedDraft.prescriptions,
    verificationHash: 'sha256_mock_hash_xyz',
    qrPayload: 'https://oms.clinic/verify/rx-qr-123',
  );

  group('CommitConsultationUseCase HITL Safety Invariants', () {
    test('Invariant 1: Throws ClinicalSafetyException when doctorApproved is false', () async {
      expect(
        () => useCase(
          CommitConsultationParams(
            draftNote: tUnapprovedDraft,
            doctorApproved: false,
            patientName: 'Ahmed Hassan',
            doctorName: 'Dr. Mohamed Mostafa',
          ),
        ),
        throwsA(
          isA<ClinicalSafetyException>()
              .having((e) => e.violationCode, 'code', 'UNAPPROVED_AI_DRAFT_COMMIT')
              .having((e) => e.message, 'message', contains('SAFETY GATE')),
        ),
      );

      verifyZeroInteractions(mockRepository);
    });

    test('Invariant 2: Successfully commits consultation and issues QR e-prescription when doctorApproved is true', () async {
      when(() => mockRepository.commitConsultation(
            draft: tApprovedDraft,
            patientName: 'Ahmed Hassan',
            doctorName: 'Dr. Mohamed Mostafa',
          )).thenAnswer((_) async => Right(tPrescriptionQr));

      final result = await useCase(
        CommitConsultationParams(
          draftNote: tApprovedDraft,
          doctorApproved: true,
          patientName: 'Ahmed Hassan',
          doctorName: 'Dr. Mohamed Mostafa',
        ),
      );

      expect(result, equals(Right(tPrescriptionQr)));
      verify(() => mockRepository.commitConsultation(
            draft: tApprovedDraft,
            patientName: 'Ahmed Hassan',
            doctorName: 'Dr. Mohamed Mostafa',
          )).called(1);
    });
  });
}
