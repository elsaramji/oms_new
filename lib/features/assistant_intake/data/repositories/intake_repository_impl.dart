import 'package:fpdart/fpdart.dart';
import 'package:oms_new/core/error/failures.dart';
import 'package:oms_new/features/assistant_intake/data/datasources/intake_local_data_source.dart';
import 'package:oms_new/features/assistant_intake/data/models/intake_vitals_model.dart';
import 'package:oms_new/features/assistant_intake/data/models/patient_summary_model.dart';
import 'package:oms_new/features/assistant_intake/domain/entities/intake_vitals_entity.dart';
import 'package:oms_new/features/assistant_intake/domain/entities/patient_summary_entity.dart';
import 'package:oms_new/features/assistant_intake/domain/repositories/intake_repository.dart';

class IntakeRepositoryImpl implements IntakeRepository {
  final IntakeLocalDataSource localDataSource;

  IntakeRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, Option<PatientSummaryEntity>>> searchPatient(
    String identifier,
  ) async {
    try {
      final patient = await localDataSource.findPatientByIdentifier(identifier);
      return Right(Option.fromNullable(patient));
    } catch (e) {
      return Left(CacheFailure('Failed to search patient: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, PatientSummaryEntity>> registerPatient(
    PatientSummaryEntity patient,
  ) async {
    try {
      final existing = await localDataSource.findPatientByIdentifier(patient.nationalId);
      if (existing != null) {
        return const Left(
          ServerFailure('A patient with this National ID is already registered.'),
        );
      }

      final model = PatientSummaryModel.fromEntity(patient);
      await localDataSource.savePatient(model);
      return Right(model);
    } catch (e) {
      return Left(CacheFailure('Failed to register patient: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, String>> forwardToQueue({
    required PatientSummaryEntity patient,
    required IntakeVitalsEntity vitals,
    String priority = 'normal',
  }) async {
    try {
      final patientModel = PatientSummaryModel.fromEntity(patient);
      final vitalsModel = IntakeVitalsModel.fromEntity(vitals);

      final queueId = await localDataSource.enqueuePatient(
        patient: patientModel,
        vitals: vitalsModel,
        priority: priority,
      );

      return Right(queueId);
    } catch (e) {
      return Left(CacheFailure('Failed to dispatch to queue: ${e.toString()}'));
    }
  }
}
