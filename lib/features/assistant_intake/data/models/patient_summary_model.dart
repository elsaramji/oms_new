import 'package:drift/drift.dart';
import 'package:oms_new/core/database/app_database.dart';
import 'package:oms_new/features/assistant_intake/domain/entities/patient_summary_entity.dart';

class PatientSummaryModel extends PatientSummaryEntity {
  const PatientSummaryModel({
    required super.id,
    required super.nationalId,
    required super.fullName,
    required super.phoneNumber,
    required super.age,
    required super.gender,
    required super.bloodType,
    super.createdAt,
  });

  factory PatientSummaryModel.fromEntity(PatientSummaryEntity entity) {
    return PatientSummaryModel(
      id: entity.id,
      nationalId: entity.nationalId,
      fullName: entity.fullName,
      phoneNumber: entity.phoneNumber,
      age: entity.age,
      gender: entity.gender,
      bloodType: entity.bloodType,
      createdAt: entity.createdAt,
    );
  }

  factory PatientSummaryModel.fromRow(PatientSummaryRow row) {
    return PatientSummaryModel(
      id: row.id,
      nationalId: row.nationalId,
      fullName: row.fullName,
      phoneNumber: row.phoneNumber,
      age: row.age,
      gender: row.gender,
      bloodType: row.bloodType,
      createdAt: row.createdAt,
    );
  }

  factory PatientSummaryModel.fromJson(Map<String, dynamic> json) {
    return PatientSummaryModel(
      id: json['id'] as String,
      nationalId: json['nationalId'] as String,
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      age: json['age'] as int,
      gender: json['gender'] as String,
      bloodType: json['bloodType'] as String,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nationalId': nationalId,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'age': age,
      'gender': gender,
      'bloodType': bloodType,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  PatientSummariesTableCompanion toCompanion() {
    return PatientSummariesTableCompanion(
      id: Value(id),
      nationalId: Value(nationalId),
      fullName: Value(fullName),
      phoneNumber: Value(phoneNumber),
      age: Value(age),
      gender: Value(gender),
      bloodType: Value(bloodType),
      createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
    );
  }
}
