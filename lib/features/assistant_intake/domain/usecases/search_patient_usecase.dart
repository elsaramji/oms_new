import 'package:fpdart/fpdart.dart';
import 'package:oms_new/core/error/failures.dart';
import 'package:oms_new/features/assistant_intake/domain/entities/patient_summary_entity.dart';
import 'package:oms_new/features/assistant_intake/domain/repositories/intake_repository.dart';

class SearchPatientUseCase {
  final IntakeRepository repository;

  SearchPatientUseCase(this.repository);

  Future<Either<Failure, Option<PatientSummaryEntity>>> call(String identifier) {
    final cleanIdentifier = identifier.trim();
    if (cleanIdentifier.isEmpty) {
      return Future.value(const Left(ServerFailure('Search identifier cannot be empty')));
    }
    return repository.searchPatient(cleanIdentifier);
  }
}
