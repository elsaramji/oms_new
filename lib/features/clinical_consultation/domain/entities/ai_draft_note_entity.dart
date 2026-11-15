import 'package:equatable/equatable.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/prescription_entity.dart';

enum DraftReviewStatus {
  draft,
  reviewed,
  approved,
  committed,
}

class AiDraftNoteEntity extends Equatable {
  final String id;
  final String patientId;
  final String subjective;
  final String objective;
  final String assessment;
  final String plan;
  final List<PrescriptionEntity> prescriptions;
  final DraftReviewStatus reviewStatus;
  final bool doctorApproved;
  final bool isAiGenerated;
  final DateTime updatedAt;

  const AiDraftNoteEntity({
    required this.id,
    required this.patientId,
    this.subjective = '',
    this.objective = '',
    this.assessment = '',
    this.plan = '',
    this.prescriptions = const [],
    this.reviewStatus = DraftReviewStatus.draft,
    this.doctorApproved = false,
    this.isAiGenerated = false,
    required this.updatedAt,
  });

  AiDraftNoteEntity copyWith({
    String? id,
    String? patientId,
    String? subjective,
    String? objective,
    String? assessment,
    String? plan,
    List<PrescriptionEntity>? prescriptions,
    DraftReviewStatus? reviewStatus,
    bool? doctorApproved,
    bool? isAiGenerated,
    DateTime? updatedAt,
  }) {
    return AiDraftNoteEntity(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      subjective: subjective ?? this.subjective,
      objective: objective ?? this.objective,
      assessment: assessment ?? this.assessment,
      plan: plan ?? this.plan,
      prescriptions: prescriptions ?? this.prescriptions,
      reviewStatus: reviewStatus ?? this.reviewStatus,
      doctorApproved: doctorApproved ?? this.doctorApproved,
      isAiGenerated: isAiGenerated ?? this.isAiGenerated,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        patientId,
        subjective,
        objective,
        assessment,
        plan,
        prescriptions,
        reviewStatus,
        doctorApproved,
        isAiGenerated,
        updatedAt,
      ];
}
