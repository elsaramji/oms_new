import 'package:fpdart/fpdart.dart';
import 'package:oms_new/core/error/failures.dart';
import 'package:oms_new/features/doctor_queue_ehr/data/datasources/doctor_queue_data_source.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/entities/ehr_timeline_entity.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/entities/queue_patient_entity.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/repositories/doctor_queue_repository.dart';

class DoctorQueueRepositoryImpl implements DoctorQueueRepository {
  final DoctorQueueDataSource dataSource;

  DoctorQueueRepositoryImpl(this.dataSource);

  @override
  Stream<List<QueuePatientEntity>> watchWaitingQueue() {
    return dataSource.watchWaitingQueue();
  }

  @override
  Future<Either<Failure, EhrTimelineEntity>> getLongitudinalEhr(
    String patientId,
  ) async {
    try {
      final ehr = await dataSource.getPatientEhr(patientId);
      return Right(ehr);
    } catch (e) {
      return Left(CacheFailure('Failed to load patient EHR: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateQueueStatus(
    String queueId,
    String status,
  ) async {
    try {
      await dataSource.updateQueueStatus(queueId, status);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure('Failed to update queue status: ${e.toString()}'));
    }
  }
}
