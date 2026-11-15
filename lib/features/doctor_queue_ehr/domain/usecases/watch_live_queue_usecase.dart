import 'package:oms_new/features/doctor_queue_ehr/domain/entities/queue_patient_entity.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/repositories/doctor_queue_repository.dart';

class WatchLiveQueueUseCase {
  final DoctorQueueRepository repository;

  WatchLiveQueueUseCase(this.repository);

  Stream<List<QueuePatientEntity>> call() {
    return repository.watchWaitingQueue();
  }
}
