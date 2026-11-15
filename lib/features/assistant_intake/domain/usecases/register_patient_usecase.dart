import 'package:fpdart/fpdart.dart';
import 'package:oms_new/core/error/failures.dart';
import 'package:oms_new/features/assistant_intake/domain/entities/patient_summary_entity.dart';
import 'package:oms_new/features/assistant_intake/domain/repositories/intake_repository.dart';

class RegisterPatientUseCase {
  final IntakeRepository repository;

  RegisterPatientUseCase(this.repository);

  Future<Either<Failure, PatientSummaryEntity>> call(PatientSummaryEntity patient) {
    if (patient.fullName.trim().isEmpty) {
      return Future.value(const Left(ServerFailure('Patient full name is required')));
    }
    if (patient.nationalId.trim().length != 14) {
      return Future.value(
        const Left(ServerFailure('Egyptian National ID must be exactly 14 digits')),
      );
    }
    if (patient.phoneNumber.trim().isEmpty) {
      return Future.value(const Left(ServerFailure('Phone number is required')));
    }
    return repository.registerPatient(patient);
  }
}
