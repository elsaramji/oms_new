import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:oms_new/core/database/daos/consultation_draft_dao.dart';
import 'package:oms_new/core/database/daos/patient_dao.dart';
import 'package:oms_new/core/database/daos/queue_dao.dart';
import 'package:oms_new/core/database/tables/tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    PatientSummariesTable,
    QueueItemsTable,
    ConsultationDraftsTable,
  ],
  daos: [
    PatientDao,
    QueueDao,
    ConsultationDraftDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  AppDatabase.memory() : super(NativeDatabase.memory());

  AppDatabase.forTesting(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final file = File('oms_clinic_portal.sqlite');
    return NativeDatabase.createInBackground(file);
  });
}
