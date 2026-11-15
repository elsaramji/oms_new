import 'package:equatable/equatable.dart';

class PatientSummaryEntity extends Equatable {
  final String id;
  final String nationalId;
  final String fullName;
  final String phoneNumber;
  final int age;
  final String gender;
  final String bloodType;
  final DateTime? createdAt;

  const PatientSummaryEntity({
    required this.id,
    required this.nationalId,
    required this.fullName,
    required this.phoneNumber,
    required this.age,
    required this.gender,
    required this.bloodType,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        nationalId,
        fullName,
        phoneNumber,
        age,
        gender,
        bloodType,
        createdAt,
      ];
}
