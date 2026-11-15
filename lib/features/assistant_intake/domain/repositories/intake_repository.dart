import 'package:fpdart/fpdart.dart';
import 'package:oms_new/core/error/failures.dart';
import 'package:oms_new/features/assistant_intake/domain/entities/intake_vitals_entity.dart';
import 'package:oms_new/features/assistant_intake/domain/entities/patient_summary_entity.dart';

abstract class IntakeRepository {
  Future<Either<Failure, Option<PatientSummaryEntity>>> searchPatient(
    String identifier,
  );

  Future<Either<Failure, PatientSummaryEntity>> registerPatient(
    PatientSummaryEntity patient,
  );

  Future<Either<Failure, String>> forwardToQueue({
    required PatientSummaryEntity patient,
    required IntakeVitalsEntity vitals,
    String priority = 'normal',
  });
}
