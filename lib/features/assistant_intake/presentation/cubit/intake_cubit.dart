import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oms_new/features/assistant_intake/domain/entities/intake_vitals_entity.dart';
import 'package:oms_new/features/assistant_intake/domain/entities/patient_summary_entity.dart';
import 'package:oms_new/features/assistant_intake/domain/usecases/forward_to_queue_usecase.dart';
import 'package:oms_new/features/assistant_intake/domain/usecases/register_patient_usecase.dart';
import 'package:oms_new/features/assistant_intake/domain/usecases/search_patient_usecase.dart';
import 'package:oms_new/features/assistant_intake/presentation/cubit/intake_state.dart';

class IntakeCubit extends Cubit<IntakeState> {
  final SearchPatientUseCase searchPatientUseCase;
  final RegisterPatientUseCase registerPatientUseCase;
  final ForwardToQueueUseCase forwardToQueueUseCase;

  IntakeCubit({
    required this.searchPatientUseCase,
    required this.registerPatientUseCase,
    required this.forwardToQueueUseCase,
  }) : super(const IntakeInitial());

  Future<void> searchPatient(String identifier) async {
    emit(const IntakeLoading());
    final result = await searchPatientUseCase(identifier);

    result.fold(
      (failure) => emit(IntakeError(failure.message)),
      (option) => option.fold(
        () => emit(PatientNotFound(identifier)),
        (patient) => emit(PatientFound(patient)),
      ),
    );
  }

  Future<void> registerPatient(PatientSummaryEntity patient) async {
    emit(const IntakeLoading());
    final result = await registerPatientUseCase(patient);

    result.fold(
      (failure) => emit(IntakeError(failure.message)),
      (registered) => emit(PatientRegistered(registered)),
    );
  }

  Future<void> forwardToQueue({
    required PatientSummaryEntity patient,
    required IntakeVitalsEntity vitals,
    String priority = 'normal',
  }) async {
    emit(const IntakeLoading());
    final result = await forwardToQueueUseCase(
      ForwardToQueueParams(
        patient: patient,
        vitals: vitals,
        priority: priority,
      ),
    );

    result.fold(
      (failure) => emit(IntakeError(failure.message)),
      (queueId) => emit(
        IntakeDispatchedToQueue(
          queueId: queueId,
          patient: patient,
        ),
      ),
    );
  }

  void reset() {
    emit(const IntakeInitial());
  }
}
