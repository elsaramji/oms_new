import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:oms_new/core/error/exceptions.dart';
import 'package:oms_new/core/error/failures.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/ai_draft_note_entity.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/prescription_qr_entity.dart';
import 'package:oms_new/features/clinical_consultation/domain/repositories/consultation_repository.dart';

class CommitConsultationParams extends Equatable {
  final AiDraftNoteEntity draftNote;
  final bool doctorApproved;
  final String patientName;
  final String doctorName;

  const CommitConsultationParams({
    required this.draftNote,
    required this.doctorApproved,
    required this.patientName,
    required this.doctorName,
  });

  @override
  List<Object?> get props => [
        draftNote,
        doctorApproved,
        patientName,
        doctorName,
      ];
}

class CommitConsultationUseCase {
  final ConsultationRepository repository;

  CommitConsultationUseCase(this.repository);

  Future<Either<Failure, PrescriptionQrEntity>> call(
    CommitConsultationParams params,
  ) async {
    // MANDATORY HUMAN-IN-THE-LOOP CLINICAL SAFETY GATE
    // Any attempt to commit without explicit doctor verification throws ClinicalSafetyException
    if (!params.doctorApproved || !params.draftNote.doctorApproved) {
      throw const ClinicalSafetyException(
        'MANDATORY HUMAN-IN-THE-LOOP SAFETY GATE: Consultation notes and e-prescriptions '
        'cannot be committed without explicit doctor review and approval.',
        violationCode: 'UNAPPROVED_AI_DRAFT_COMMIT',
      );
    }

    return repository.commitConsultation(
      draft: params.draftNote,
      patientName: params.patientName,
      doctorName: params.doctorName,
    );
  }
}
