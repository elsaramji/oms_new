import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:oms_new/core/database/app_database.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/ai_draft_note_entity.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/prescription_entity.dart';

class ConsultationDraftModel extends AiDraftNoteEntity {
  const ConsultationDraftModel({
    required super.id,
    required super.patientId,
    super.subjective,
    super.objective,
    super.assessment,
    super.plan,
    super.prescriptions,
    super.reviewStatus,
    super.doctorApproved,
    super.isAiGenerated,
    required super.updatedAt,
  });

  factory ConsultationDraftModel.fromEntity(AiDraftNoteEntity entity) {
    return ConsultationDraftModel(
      id: entity.id,
      patientId: entity.patientId,
      subjective: entity.subjective,
      objective: entity.objective,
      assessment: entity.assessment,
      plan: entity.plan,
      prescriptions: entity.prescriptions,
      reviewStatus: entity.reviewStatus,
      doctorApproved: entity.doctorApproved,
      isAiGenerated: entity.isAiGenerated,
      updatedAt: entity.updatedAt,
    );
  }

  factory ConsultationDraftModel.fromRow(ConsultationDraftRow row) {
    List<PrescriptionEntity> prescriptionsList = [];
    if (row.prescriptionsJson.isNotEmpty) {
      try {
        final decoded = jsonDecode(row.prescriptionsJson) as List<dynamic>;
        prescriptionsList = decoded.map((item) {
          final m = item as Map<String, dynamic>;
          return PrescriptionEntity(
            id: m['id'] as String? ?? '',
            medicationName: m['medicationName'] as String? ?? '',
            dosage: m['dosage'] as String? ?? '',
            frequency: m['frequency'] as String? ?? '',
            duration: m['duration'] as String? ?? '',
            instructions: m['instructions'] as String? ?? '',
          );
        }).toList();
      } catch (_) {}
    }

    DraftReviewStatus status = DraftReviewStatus.draft;
    switch (row.reviewStatus) {
      case 'reviewed':
        status = DraftReviewStatus.reviewed;
        break;
      case 'approved':
        status = DraftReviewStatus.approved;
        break;
      case 'committed':
        status = DraftReviewStatus.committed;
        break;
      default:
        status = DraftReviewStatus.draft;
    }

    return ConsultationDraftModel(
      id: row.id,
      patientId: row.patientId,
      subjective: row.subjective,
      objective: row.objective,
      assessment: row.assessment,
      plan: row.plan,
      prescriptions: prescriptionsList,
      reviewStatus: status,
      doctorApproved: row.doctorApproved,
      isAiGenerated: true,
      updatedAt: row.updatedAt,
    );
  }

  ConsultationDraftsTableCompanion toCompanion() {
    final prescriptionsJsonString = jsonEncode(
      prescriptions.map((p) => {
            'id': p.id,
            'medicationName': p.medicationName,
            'dosage': p.dosage,
            'frequency': p.frequency,
            'duration': p.duration,
            'instructions': p.instructions,
          }).toList(),
    );

    return ConsultationDraftsTableCompanion(
      id: Value(id),
      patientId: Value(patientId),
      doctorApproved: Value(doctorApproved),
      reviewStatus: Value(reviewStatus.name),
      subjective: Value(subjective),
      objective: Value(objective),
      assessment: Value(assessment),
      plan: Value(plan),
      prescriptionsJson: Value(prescriptionsJsonString),
      updatedAt: Value(updatedAt),
    );
  }
}
