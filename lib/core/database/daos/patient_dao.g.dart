// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_dao.dart';

// ignore_for_file: type=lint
mixin _$PatientDaoMixin on DatabaseAccessor<AppDatabase> {
  $PatientSummariesTableTable get patientSummariesTable =>
      attachedDatabase.patientSummariesTable;
  PatientDaoManager get managers => PatientDaoManager(this);
}

class PatientDaoManager {
  final _$PatientDaoMixin _db;
  PatientDaoManager(this._db);
  $$PatientSummariesTableTableTableManager get patientSummariesTable =>
      $$PatientSummariesTableTableTableManager(
        _db.attachedDatabase,
        _db.patientSummariesTable,
      );
}
