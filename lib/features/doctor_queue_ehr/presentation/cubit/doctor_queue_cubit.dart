import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/entities/queue_patient_entity.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/repositories/doctor_queue_repository.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/usecases/get_longitudinal_ehr_usecase.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/usecases/watch_live_queue_usecase.dart';
import 'package:oms_new/features/doctor_queue_ehr/presentation/cubit/doctor_queue_state.dart';

class DoctorQueueCubit extends Cubit<DoctorQueueState> {
  final WatchLiveQueueUseCase watchLiveQueueUseCase;
  final GetLongitudinalEhrUseCase getLongitudinalEhrUseCase;
  final DoctorQueueRepository repository;

  StreamSubscription<List<QueuePatientEntity>>? _queueSubscription;

  DoctorQueueCubit({
    required this.watchLiveQueueUseCase,
    required this.getLongitudinalEhrUseCase,
    required this.repository,
  }) : super(const DoctorQueueInitial());

  void startQueueSubscription() {
    emit(const DoctorQueueLoading());
    _queueSubscription?.cancel();
    _queueSubscription = watchLiveQueueUseCase().listen(
      (patients) {
        if (state is DoctorQueueLoaded) {
          final current = state as DoctorQueueLoaded;
          emit(current.copyWith(queuePatients: patients));
        } else {
          emit(DoctorQueueLoaded(queuePatients: patients));
        }
      },
      onError: (err) {
        emit(DoctorQueueError('Failed to stream queue: ${err.toString()}'));
      },
    );
  }

  Future<void> selectPatient(QueuePatientEntity patient) async {
    if (state is! DoctorQueueLoaded) return;
    final current = state as DoctorQueueLoaded;

    emit(current.copyWith(
      selectedPatient: patient,
      isLoadingEhr: true,
      clearSelection: false,
    ));

    // Mark status in consultation
    await repository.updateQueueStatus(patient.id, 'inConsultation');

    // Load EHR timeline
    final ehrResult = await getLongitudinalEhrUseCase(patient.patientId);

    ehrResult.fold(
      (failure) {
        if (state is DoctorQueueLoaded) {
          emit((state as DoctorQueueLoaded).copyWith(
            isLoadingEhr: false,
            errorMessage: failure.message,
          ));
        }
      },
      (ehr) {
        if (state is DoctorQueueLoaded) {
          emit((state as DoctorQueueLoaded).copyWith(
            selectedPatientEhr: ehr,
            isLoadingEhr: false,
          ));
        }
      },
    );
  }

  void clearSelection() {
    if (state is DoctorQueueLoaded) {
      emit((state as DoctorQueueLoaded).copyWith(clearSelection: true));
    }
  }

  @override
  Future<void> close() {
    _queueSubscription?.cancel();
    return super.close();
  }
}
