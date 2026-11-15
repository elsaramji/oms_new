import 'package:fpdart/fpdart.dart';
import 'package:oms_new/core/error/failures.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/entities/ehr_timeline_entity.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/entities/queue_patient_entity.dart';

abstract class DoctorQueueRepository {
  Stream<List<QueuePatientEntity>> watchWaitingQueue();
  Future<Either<Failure, EhrTimelineEntity>> getLongitudinalEhr(String patientId);
  Future<Either<Failure, Unit>> updateQueueStatus(String queueId, String status);
}
