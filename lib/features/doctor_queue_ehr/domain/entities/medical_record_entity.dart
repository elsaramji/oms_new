import 'package:equatable/equatable.dart';

class MedicalRecordEntity extends Equatable {
  final String visitId;
  final DateTime visitDate;
  final String attendingDoctor;
  final String chiefComplaint;
  final String diagnosis;
  final List<String> prescriptions;

  const MedicalRecordEntity({
    required this.visitId,
    required this.visitDate,
    required this.attendingDoctor,
    required this.chiefComplaint,
    required this.diagnosis,
    required this.prescriptions,
  });

  @override
  List<Object?> get props => [
        visitId,
        visitDate,
        attendingDoctor,
        chiefComplaint,
        diagnosis,
        prescriptions,
      ];
}
