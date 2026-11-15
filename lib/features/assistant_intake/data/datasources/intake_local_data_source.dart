import 'package:drift/drift.dart';
import 'package:oms_new/core/database/app_database.dart';
import 'package:oms_new/core/database/daos/patient_dao.dart';
import 'package:oms_new/core/database/daos/queue_dao.dart';
import 'package:oms_new/features/assistant_intake/data/models/intake_vitals_model.dart';
import 'package:oms_new/features/assistant_intake/data/models/patient_summary_model.dart';

abstract class IntakeLocalDataSource {
  Future<PatientSummaryModel?> findPatientByIdentifier(String identifier);
  Future<void> savePatient(PatientSummaryModel patient);
  Future<String> enqueuePatient({
    required PatientSummaryModel patient,
    required IntakeVitalsModel vitals,
    String priority = 'normal',
  });
}

class IntakeLocalDataSourceImpl implements IntakeLocalDataSource {
  final PatientDao patientDao;
  final QueueDao queueDao;

  IntakeLocalDataSourceImpl({
    required this.patientDao,
    required this.queueDao,
  });

  @override
  Future<PatientSummaryModel?> findPatientByIdentifier(String identifier) async {
    final row = await patientDao.findByIdentifier(identifier);
    if (row == null) return null;
    return PatientSummaryModel.fromRow(row);
  }

  @override
  Future<void> savePatient(PatientSummaryModel patient) async {
    await patientDao.insertOrUpdatePatient(patient.toCompanion());
  }

  @override
  Future<String> enqueuePatient({
    required PatientSummaryModel patient,
    required IntakeVitalsModel vitals,
    String priority = 'normal',
  }) async {
    final queueId = 'queue-${DateTime.now().millisecondsSinceEpoch}';
    final existingItems = await queueDao.getWaitingQueue();
    final nextNumber = existingItems.length + 1;

    await queueDao.insertQueueItem(
      QueueItemsTableCompanion(
        id: Value(queueId),
        patientId: Value(patient.id),
        patientName: Value(patient.fullName),
        queueNumber: Value(nextNumber),
        status: const Value('waiting'),
        priority: Value(priority),
        forwardedAt: Value(DateTime.now()),
        systolicBp: Value(vitals.systolicBp),
        diastolicBp: Value(vitals.diastolicBp),
        pulseRate: Value(vitals.pulseRate),
        temperature: Value(vitals.temperature),
        oxygenSaturation: Value(vitals.oxygenSaturation),
        weight: Value(vitals.weight),
        height: Value(vitals.height),
        bmi: Value(vitals.bmi),
      ),
    );

    return queueId;
  }
}
