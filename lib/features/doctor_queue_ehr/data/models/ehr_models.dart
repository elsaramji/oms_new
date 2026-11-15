import 'package:oms_new/features/doctor_queue_ehr/domain/entities/allergy_alert_entity.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/entities/ehr_timeline_entity.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/entities/medical_record_entity.dart';

class AllergyAlertModel extends AllergyAlertEntity {
  const AllergyAlertModel({
    required super.allergen,
    required super.severity,
    required super.reaction,
  });

  factory AllergyAlertModel.fromJson(Map<String, dynamic> json) {
    return AllergyAlertModel(
      allergen: json['allergen'] as String? ?? '',
      severity: json['severity'] as String? ?? 'Moderate',
      reaction: json['reaction'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'allergen': allergen,
      'severity': severity,
      'reaction': reaction,
    };
  }
}

class MedicalRecordModel extends MedicalRecordEntity {
  const MedicalRecordModel({
    required super.visitId,
    required super.visitDate,
    required super.attendingDoctor,
    required super.chiefComplaint,
    required super.diagnosis,
    required super.prescriptions,
  });

  factory MedicalRecordModel.fromJson(Map<String, dynamic> json) {
    return MedicalRecordModel(
      visitId: json['visitId'] as String? ?? '',
      visitDate: json['visitDate'] != null
          ? DateTime.parse(json['visitDate'] as String)
          : DateTime.now(),
      attendingDoctor: json['attendingDoctor'] as String? ?? '',
      chiefComplaint: json['chiefComplaint'] as String? ?? '',
      diagnosis: json['diagnosis'] as String? ?? '',
      prescriptions: (json['prescriptions'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'visitId': visitId,
      'visitDate': visitDate.toIso8601String(),
      'attendingDoctor': attendingDoctor,
      'chiefComplaint': chiefComplaint,
      'diagnosis': diagnosis,
      'prescriptions': prescriptions,
    };
  }
}

class EhrTimelineModel extends EhrTimelineEntity {
  const EhrTimelineModel({
    required super.patientId,
    required List<AllergyAlertModel> super.allergies,
    required super.chronicConditions,
    required List<MedicalRecordModel> super.records,
  });

  factory EhrTimelineModel.fromJson(Map<String, dynamic> json) {
    return EhrTimelineModel(
      patientId: json['patientId'] as String? ?? '',
      allergies: (json['allergies'] as List<dynamic>?)
              ?.map((e) => AllergyAlertModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      chronicConditions: (json['chronicConditions'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      records: (json['records'] as List<dynamic>?)
              ?.map((e) => MedicalRecordModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'allergies': (allergies as List<AllergyAlertModel>).map((a) => a.toJson()).toList(),
      'chronicConditions': chronicConditions,
      'records': (records as List<MedicalRecordModel>).map((r) => r.toJson()).toList(),
    };
  }
}
