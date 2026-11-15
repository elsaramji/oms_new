import 'package:equatable/equatable.dart';
import 'package:oms_new/features/assistant_intake/domain/entities/patient_summary_entity.dart';

abstract class IntakeState extends Equatable {
  const IntakeState();

  @override
  List<Object?> get props => [];
}

class IntakeInitial extends IntakeState {
  const IntakeInitial();
}

class IntakeLoading extends IntakeState {
  const IntakeLoading();
}

class PatientFound extends IntakeState {
  final PatientSummaryEntity patient;

  const PatientFound(this.patient);

  @override
  List<Object?> get props => [patient];
}

class PatientNotFound extends IntakeState {
  final String searchedIdentifier;

  const PatientNotFound(this.searchedIdentifier);

  @override
  List<Object?> get props => [searchedIdentifier];
}

class PatientRegistered extends IntakeState {
  final PatientSummaryEntity patient;

  const PatientRegistered(this.patient);

  @override
  List<Object?> get props => [patient];
}

class IntakeDispatchedToQueue extends IntakeState {
  final String queueId;
  final PatientSummaryEntity patient;

  const IntakeDispatchedToQueue({
    required this.queueId,
    required this.patient,
  });

  @override
  List<Object?> get props => [queueId, patient];
}

class IntakeError extends IntakeState {
  final String message;

  const IntakeError(this.message);

  @override
  List<Object?> get props => [message];
}
