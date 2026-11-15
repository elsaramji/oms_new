import 'package:equatable/equatable.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/ai_draft_note_entity.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/prescription_qr_entity.dart';

abstract class ConsultationState extends Equatable {
  const ConsultationState();

  @override
  List<Object?> get props => [];
}

class ConsultationInitial extends ConsultationState {
  const ConsultationInitial();
}

class ConsultationLoading extends ConsultationState {
  const ConsultationLoading();
}

class ConsultationDraftLoaded extends ConsultationState {
  final AiDraftNoteEntity draft;
  final bool isGeneratingScribe;
  final bool isSaving;
  final bool isCommitting;
  final String? errorMessage;

  const ConsultationDraftLoaded({
    required this.draft,
    this.isGeneratingScribe = false,
    this.isSaving = false,
    this.isCommitting = false,
    this.errorMessage,
  });

  ConsultationDraftLoaded copyWith({
    AiDraftNoteEntity? draft,
    bool? isGeneratingScribe,
    bool? isSaving,
    bool? isCommitting,
    String? errorMessage,
  }) {
    return ConsultationDraftLoaded(
      draft: draft ?? this.draft,
      isGeneratingScribe: isGeneratingScribe ?? this.isGeneratingScribe,
      isSaving: isSaving ?? this.isSaving,
      isCommitting: isCommitting ?? this.isCommitting,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        draft,
        isGeneratingScribe,
        isSaving,
        isCommitting,
        errorMessage,
      ];
}

class ConsultationCommitted extends ConsultationState {
  final PrescriptionQrEntity prescriptionQr;

  const ConsultationCommitted(this.prescriptionQr);

  @override
  List<Object?> get props => [prescriptionQr];
}

class ConsultationError extends ConsultationState {
  final String message;

  const ConsultationError(this.message);

  @override
  List<Object?> get props => [message];
}
