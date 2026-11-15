import 'package:drift/drift.dart';

@DataClassName('PatientSummaryRow')
class PatientSummariesTable extends Table {
  TextColumn get id => text()();
  TextColumn get nationalId => text()();
  TextColumn get fullName => text()();
  TextColumn get phoneNumber => text()();
  IntColumn get age => integer()();
  TextColumn get gender => text()();
  TextColumn get bloodType => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('QueueItemRow')
class QueueItemsTable extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text()();
  TextColumn get patientName => text()();
  IntColumn get queueNumber => integer()();
  TextColumn get status => text().withDefault(const Constant('waiting'))();
  TextColumn get priority => text().withDefault(const Constant('normal'))();
  DateTimeColumn get forwardedAt => dateTime().withDefault(currentDateAndTime)();
  
  // Vitals snapshot
  IntColumn get systolicBp => integer().nullable()();
  IntColumn get diastolicBp => integer().nullable()();
  IntColumn get pulseRate => integer().nullable()();
  RealColumn get temperature => real().nullable()();
  RealColumn get oxygenSaturation => real().nullable()();
  RealColumn get weight => real().nullable()();
  RealColumn get height => real().nullable()();
  RealColumn get bmi => real().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ConsultationDraftRow')
class ConsultationDraftsTable extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text()();
  BoolColumn get doctorApproved => boolean().withDefault(const Constant(false))();
  TextColumn get reviewStatus => text().withDefault(const Constant('draft'))();
  TextColumn get subjective => text().withDefault(const Constant(''))();
  TextColumn get objective => text().withDefault(const Constant(''))();
  TextColumn get assessment => text().withDefault(const Constant(''))();
  TextColumn get plan => text().withDefault(const Constant(''))();
  TextColumn get prescriptionsJson => text().withDefault(const Constant('[]'))();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
