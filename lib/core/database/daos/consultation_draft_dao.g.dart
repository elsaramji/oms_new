// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consultation_draft_dao.dart';

// ignore_for_file: type=lint
mixin _$ConsultationDraftDaoMixin on DatabaseAccessor<AppDatabase> {
  $ConsultationDraftsTableTable get consultationDraftsTable =>
      attachedDatabase.consultationDraftsTable;
  ConsultationDraftDaoManager get managers => ConsultationDraftDaoManager(this);
}

class ConsultationDraftDaoManager {
  final _$ConsultationDraftDaoMixin _db;
  ConsultationDraftDaoManager(this._db);
  $$ConsultationDraftsTableTableTableManager get consultationDraftsTable =>
      $$ConsultationDraftsTableTableTableManager(
        _db.attachedDatabase,
        _db.consultationDraftsTable,
      );
}
