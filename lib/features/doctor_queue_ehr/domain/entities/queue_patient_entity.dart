import 'package:equatable/equatable.dart';
import 'package:oms_new/features/assistant_intake/domain/entities/intake_vitals_entity.dart';

class QueuePatientEntity extends Equatable {
  final String id;
  final String patientId;
  final String patientName;
  final int queueNumber;
  final String status;
  final String priority;
  final DateTime forwardedAt;
  final IntakeVitalsEntity? vitals;

  const QueuePatientEntity({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.queueNumber,
    required this.status,
    required this.priority,
    required this.forwardedAt,
    this.vitals,
  });

  bool get isUrgent => priority.toLowerCase() == 'urgent';
  bool get isWaiting => status == 'waiting';
  bool get isInConsultation => status == 'inConsultation';
  bool get isCompleted => status == 'completed';

  @override
  List<Object?> get props => [
        id,
        patientId,
        patientName,
        queueNumber,
        status,
        priority,
        forwardedAt,
        vitals,
      ];
}
