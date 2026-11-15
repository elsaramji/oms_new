import 'package:fpdart/fpdart.dart';
import 'package:oms_new/core/error/failures.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/ai_draft_note_entity.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/prescription_qr_entity.dart';

abstract class ConsultationRepository {
  Future<Either<Failure, Option<AiDraftNoteEntity>>> getActiveDraft(String patientId);

  Future<Either<Failure, Unit>> saveDraft(AiDraftNoteEntity draft);

  Future<Either<Failure, AiDraftNoteEntity>> generateSimulatedAiScribe(String patientId);

  Future<Either<Failure, PrescriptionQrEntity>> commitConsultation({
    required AiDraftNoteEntity draft,
    required String patientName,
    required String doctorName,
  });
}
