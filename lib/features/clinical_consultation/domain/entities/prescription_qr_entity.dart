import 'package:equatable/equatable.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/prescription_entity.dart';

class PrescriptionQrEntity extends Equatable {
  final String prescriptionId;
  final String patientId;
  final String patientName;
  final String doctorName;
  final DateTime issuedAt;
  final List<PrescriptionEntity> medications;
  final String verificationHash;
  final String qrPayload;

  const PrescriptionQrEntity({
    required this.prescriptionId,
    required this.patientId,
    required this.patientName,
    required this.doctorName,
    required this.issuedAt,
    required this.medications,
    required this.verificationHash,
    required this.qrPayload,
  });

  @override
  List<Object?> get props => [
        prescriptionId,
        patientId,
        patientName,
        doctorName,
        issuedAt,
        medications,
        verificationHash,
        qrPayload,
      ];
}
