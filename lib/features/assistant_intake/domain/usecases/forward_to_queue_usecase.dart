import 'package:fpdart/fpdart.dart';
import 'package:oms_new/core/error/failures.dart';
import 'package:oms_new/features/assistant_intake/domain/entities/intake_vitals_entity.dart';
import 'package:oms_new/features/assistant_intake/domain/entities/patient_summary_entity.dart';
import 'package:oms_new/features/assistant_intake/domain/repositories/intake_repository.dart';

class ForwardToQueueParams {
  final PatientSummaryEntity patient;
  final IntakeVitalsEntity vitals;
  final String priority;

  const ForwardToQueueParams({
    required this.patient,
    required this.vitals,
    this.priority = 'normal',
  });
}

class ForwardToQueueUseCase {
  final IntakeRepository repository;

  ForwardToQueueUseCase(this.repository);

  Future<Either<Failure, String>> call(ForwardToQueueParams params) {
    if (!params.vitals.isValid) {
      return Future.value(
        const Left(
          ClinicalSafetyFailure(
            'Vitals outside physiological safety limits. Please correct before queue dispatch.',
          ),
        ),
      );
    }

    return repository.forwardToQueue(
      patient: params.patient,
      vitals: params.vitals,
      priority: params.priority,
    );
  }
}
