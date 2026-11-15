import 'package:equatable/equatable.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/entities/ehr_timeline_entity.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/entities/queue_patient_entity.dart';

abstract class DoctorQueueState extends Equatable {
  const DoctorQueueState();

  @override
  List<Object?> get props => [];
}

class DoctorQueueInitial extends DoctorQueueState {
  const DoctorQueueInitial();
}

class DoctorQueueLoading extends DoctorQueueState {
  const DoctorQueueLoading();
}

class DoctorQueueLoaded extends DoctorQueueState {
  final List<QueuePatientEntity> queuePatients;
  final QueuePatientEntity? selectedPatient;
  final EhrTimelineEntity? selectedPatientEhr;
  final bool isLoadingEhr;
  final String? errorMessage;

  const DoctorQueueLoaded({
    required this.queuePatients,
    this.selectedPatient,
    this.selectedPatientEhr,
    this.isLoadingEhr = false,
    this.errorMessage,
  });

  DoctorQueueLoaded copyWith({
    List<QueuePatientEntity>? queuePatients,
    QueuePatientEntity? selectedPatient,
    EhrTimelineEntity? selectedPatientEhr,
    bool? isLoadingEhr,
    String? errorMessage,
    bool clearSelection = false,
  }) {
    return DoctorQueueLoaded(
      queuePatients: queuePatients ?? this.queuePatients,
      selectedPatient:
          clearSelection ? null : (selectedPatient ?? this.selectedPatient),
      selectedPatientEhr: clearSelection
          ? null
          : (selectedPatientEhr ?? this.selectedPatientEhr),
      isLoadingEhr: isLoadingEhr ?? this.isLoadingEhr,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        queuePatients,
        selectedPatient,
        selectedPatientEhr,
        isLoadingEhr,
        errorMessage,
      ];
}

class DoctorQueueError extends DoctorQueueState {
  final String message;

  const DoctorQueueError(this.message);

  @override
  List<Object?> get props => [message];
}
