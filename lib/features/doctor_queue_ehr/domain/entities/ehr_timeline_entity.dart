import 'package:equatable/equatable.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/entities/allergy_alert_entity.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/entities/medical_record_entity.dart';

class EhrTimelineEntity extends Equatable {
  final String patientId;
  final List<AllergyAlertEntity> allergies;
  final List<String> chronicConditions;
  final List<MedicalRecordEntity> records;

  const EhrTimelineEntity({
    required this.patientId,
    required this.allergies,
    required this.chronicConditions,
    required this.records,
  });

  bool get hasSevereAllergies => allergies.any((a) => a.isSevere);
  bool get hasChronicConditions => chronicConditions.isNotEmpty;

  @override
  List<Object?> get props => [
        patientId,
        allergies,
        chronicConditions,
        records,
      ];
}
