import 'package:drift/drift.dart';
import 'package:oms_new/core/database/app_database.dart';
import 'package:oms_new/core/database/tables/tables.dart';

part 'patient_dao.g.dart';

@DriftAccessor(tables: [PatientSummariesTable])
class PatientDao extends DatabaseAccessor<AppDatabase> with _$PatientDaoMixin {
  PatientDao(super.db);

  Future<int> insertOrUpdatePatient(PatientSummariesTableCompanion entry) {
    return into(patientSummariesTable).insertOnConflictUpdate(entry);
  }

  Future<PatientSummaryRow?> getPatientById(String id) {
    return (select(patientSummariesTable)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<PatientSummaryRow?> findByIdentifier(String identifier) {
    return (select(patientSummariesTable)
          ..where((tbl) =>
              tbl.nationalId.equals(identifier) | tbl.phoneNumber.equals(identifier)))
        .getSingleOrNull();
  }

  Stream<List<PatientSummaryRow>> watchAllPatients() {
    return select(patientSummariesTable).watch();
  }
}
