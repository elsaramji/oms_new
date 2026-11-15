import 'package:fpdart/fpdart.dart';
import 'package:oms_new/core/error/failures.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/entities/ehr_timeline_entity.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/repositories/doctor_queue_repository.dart';

class GetLongitudinalEhrUseCase {
  final DoctorQueueRepository repository;

  GetLongitudinalEhrUseCase(this.repository);

  Future<Either<Failure, EhrTimelineEntity>> call(String patientId) {
    if (patientId.trim().isEmpty) {
      return Future.value(const Left(ServerFailure('Patient ID is required')));
    }
    return repository.getLongitudinalEhr(patientId.trim());
  }
}
