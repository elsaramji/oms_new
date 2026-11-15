import 'package:oms_new/core/database/app_database.dart';
import 'package:oms_new/features/assistant_intake/domain/entities/intake_vitals_entity.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/entities/queue_patient_entity.dart';

class QueuePatientModel extends QueuePatientEntity {
  const QueuePatientModel({
    required super.id,
    required super.patientId,
    required super.patientName,
    required super.queueNumber,
    required super.status,
    required super.priority,
    required super.forwardedAt,
    super.vitals,
  });

  factory QueuePatientModel.fromRow(QueueItemRow row) {
    IntakeVitalsEntity? vitals;
    if (row.systolicBp != null && row.diastolicBp != null) {
      vitals = IntakeVitalsEntity(
        systolicBp: row.systolicBp!,
        diastolicBp: row.diastolicBp!,
        pulseRate: row.pulseRate ?? 72,
        temperature: row.temperature ?? 37.0,
        oxygenSaturation: row.oxygenSaturation ?? 98.0,
        weight: row.weight ?? 70.0,
        height: row.height ?? 170.0,
        customBmi: row.bmi,
      );
    }

    return QueuePatientModel(
      id: row.id,
      patientId: row.patientId,
      patientName: row.patientName,
      queueNumber: row.queueNumber,
      status: row.status,
      priority: row.priority,
      forwardedAt: row.forwardedAt,
      vitals: vitals,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'patientName': patientName,
      'queueNumber': queueNumber,
      'status': status,
      'priority': priority,
      'forwardedAt': forwardedAt.toIso8601String(),
    };
  }
}
