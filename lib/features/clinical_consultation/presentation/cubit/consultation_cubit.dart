import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oms_new/core/error/exceptions.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/ai_draft_note_entity.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/prescription_entity.dart';
import 'package:oms_new/features/clinical_consultation/domain/repositories/consultation_repository.dart';
import 'package:oms_new/features/clinical_consultation/domain/usecases/commit_consultation_usecase.dart';
import 'package:oms_new/features/clinical_consultation/presentation/cubit/consultation_state.dart';

class ConsultationCubit extends Cubit<ConsultationState> {
  final ConsultationRepository repository;
  final CommitConsultationUseCase commitConsultationUseCase;

  ConsultationCubit({
    required this.repository,
    required this.commitConsultationUseCase,
  }) : super(const ConsultationInitial());

  Future<void> initDraftForPatient(String patientId) async {
    emit(const ConsultationLoading());
    final result = await repository.getActiveDraft(patientId);

    result.fold(
      (failure) => emit(ConsultationError(failure.message)),
      (option) {
        final existing = option.fold(
          () => AiDraftNoteEntity(
            id: 'draft-${DateTime.now().millisecondsSinceEpoch}',
            patientId: patientId,
            reviewStatus: DraftReviewStatus.draft,
            doctorApproved: false,
            updatedAt: DateTime.now(),
          ),
          (draft) => draft,
        );
        emit(ConsultationDraftLoaded(draft: existing));
      },
    );
  }

  Future<void> generateAiScribe(String patientId) async {
    if (state is! ConsultationDraftLoaded) return;
    final current = state as ConsultationDraftLoaded;
    emit(current.copyWith(isGeneratingScribe: true));

    final result = await repository.generateSimulatedAiScribe(patientId);

    result.fold(
      (failure) => emit(current.copyWith(
        isGeneratingScribe: false,
        errorMessage: failure.message,
      )),
      (newDraft) => emit(current.copyWith(
        draft: newDraft,
        isGeneratingScribe: false,
      )),
    );
  }

  void updateSoapFields({
    String? subjective,
    String? objective,
    String? assessment,
    String? plan,
  }) {
    if (state is! ConsultationDraftLoaded) return;
    final current = state as ConsultationDraftLoaded;

    final updatedDraft = current.draft.copyWith(
      subjective: subjective ?? current.draft.subjective,
      objective: objective ?? current.draft.objective,
      assessment: assessment ?? current.draft.assessment,
      plan: plan ?? current.draft.plan,
      updatedAt: DateTime.now(),
    );

    emit(current.copyWith(draft: updatedDraft));
    repository.saveDraft(updatedDraft);
  }

  void setDoctorApproval(bool approved) {
    if (state is! ConsultationDraftLoaded) return;
    final current = state as ConsultationDraftLoaded;

    final updatedDraft = current.draft.copyWith(
      doctorApproved: approved,
      reviewStatus: approved ? DraftReviewStatus.approved : DraftReviewStatus.draft,
      updatedAt: DateTime.now(),
    );

    emit(current.copyWith(draft: updatedDraft));
    repository.saveDraft(updatedDraft);
  }

  void addPrescription(PrescriptionEntity prescription) {
    if (state is! ConsultationDraftLoaded) return;
    final current = state as ConsultationDraftLoaded;

    final updatedList = List<PrescriptionEntity>.from(current.draft.prescriptions)
      ..add(prescription);
    final updatedDraft = current.draft.copyWith(
      prescriptions: updatedList,
      updatedAt: DateTime.now(),
    );

    emit(current.copyWith(draft: updatedDraft));
    repository.saveDraft(updatedDraft);
  }

  void removePrescription(String prescriptionId) {
    if (state is! ConsultationDraftLoaded) return;
    final current = state as ConsultationDraftLoaded;

    final updatedList = current.draft.prescriptions
        .where((p) => p.id != prescriptionId)
        .toList();
    final updatedDraft = current.draft.copyWith(
      prescriptions: updatedList,
      updatedAt: DateTime.now(),
    );

    emit(current.copyWith(draft: updatedDraft));
    repository.saveDraft(updatedDraft);
  }

  Future<void> commitConsultation({
    required String patientName,
    required String doctorName,
  }) async {
    if (state is! ConsultationDraftLoaded) return;
    final current = state as ConsultationDraftLoaded;

    emit(current.copyWith(isCommitting: true));

    try {
      final result = await commitConsultationUseCase(
        CommitConsultationParams(
          draftNote: current.draft,
          doctorApproved: current.draft.doctorApproved,
          patientName: patientName,
          doctorName: doctorName,
        ),
      );

      result.fold(
        (failure) => emit(current.copyWith(
          isCommitting: false,
          errorMessage: failure.message,
        )),
        (prescriptionQr) => emit(ConsultationCommitted(prescriptionQr)),
      );
    } on ClinicalSafetyException catch (e) {
      emit(current.copyWith(
        isCommitting: false,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(current.copyWith(
        isCommitting: false,
        errorMessage: e.toString(),
      ));
    }
  }
}
