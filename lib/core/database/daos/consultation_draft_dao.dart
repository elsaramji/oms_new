import 'package:drift/drift.dart';
import 'package:oms_new/core/database/app_database.dart';
import 'package:oms_new/core/database/tables/tables.dart';

part 'consultation_draft_dao.g.dart';

@DriftAccessor(tables: [ConsultationDraftsTable])
class ConsultationDraftDao extends DatabaseAccessor<AppDatabase>
    with _$ConsultationDraftDaoMixin {
  ConsultationDraftDao(super.db);

  Future<int> insertOrUpdateDraft(ConsultationDraftsTableCompanion draft) {
    return into(consultationDraftsTable).insertOnConflictUpdate(draft);
  }

  Future<ConsultationDraftRow?> getDraftByPatientId(String patientId) {
    return (select(consultationDraftsTable)
          ..where((tbl) => tbl.patientId.equals(patientId)))
        .getSingleOrNull();
  }

  Stream<ConsultationDraftRow?> watchDraftByPatientId(String patientId) {
    return (select(consultationDraftsTable)
          ..where((tbl) => tbl.patientId.equals(patientId)))
        .watchSingleOrNull();
  }

  Future<int> deleteDraftByPatientId(String patientId) {
    return (delete(consultationDraftsTable)
          ..where((tbl) => tbl.patientId.equals(patientId)))
        .go();
  }
}
