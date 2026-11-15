import 'package:drift/drift.dart' as drift;
import 'package:flutter_test/flutter_test.dart';
import 'package:oms_new/core/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.memory();
  });

  tearDown(() async {
    await db.close();
  });

  group('PatientDao', () {
    test('inserts and retrieves patient by identifier', () async {
      await db.patientDao.insertOrUpdatePatient(
        PatientSummariesTableCompanion(
          id: const drift.Value('p-001'),
          nationalId: const drift.Value('29501011234567'),
          fullName: const drift.Value('Ahmed Hassan'),
          phoneNumber: const drift.Value('+201001234567'),
          age: const drift.Value(45),
          gender: const drift.Value('male'),
          bloodType: const drift.Value('A+'),
        ),
      );

      final byNatId = await db.patientDao.findByIdentifier('29501011234567');
      expect(byNatId, isNotNull);
      expect(byNatId!.fullName, equals('Ahmed Hassan'));

      final byPhone = await db.patientDao.findByIdentifier('+201001234567');
      expect(byPhone, isNotNull);
      expect(byPhone!.id, equals('p-001'));
    });
  });

  group('QueueDao', () {
    test('inserts item and watches waiting queue reactively', () async {
      await db.queueDao.insertQueueItem(
        QueueItemsTableCompanion(
          id: const drift.Value('q-1'),
          patientId: const drift.Value('p-001'),
          patientName: const drift.Value('Ahmed Hassan'),
          queueNumber: const drift.Value(1),
          status: const drift.Value('waiting'),
          priority: const drift.Value('normal'),
          systolicBp: const drift.Value(120),
          diastolicBp: const drift.Value(80),
          pulseRate: const drift.Value(72),
          bmi: const drift.Value(24.5),
        ),
      );

      final items = await db.queueDao.getWaitingQueue();
      expect(items.length, equals(1));
      expect(items.first.patientName, equals('Ahmed Hassan'));

      final firstEmission = await db.queueDao.watchWaitingQueue().first;
      expect(firstEmission.length, equals(1));
      expect(firstEmission.first.id, equals('q-1'));
    });
  });

  group('ConsultationDraftDao', () {
    test('saves draft and allows reactive watching', () async {
      await db.consultationDraftDao.insertOrUpdateDraft(
        ConsultationDraftsTableCompanion(
          id: const drift.Value('draft-1'),
          patientId: const drift.Value('p-001'),
          doctorApproved: const drift.Value(false),
          reviewStatus: const drift.Value('draft'),
          subjective: const drift.Value('Complains of severe headache'),
          objective: const drift.Value('BP 120/80'),
          assessment: const drift.Value('Tension headache'),
          plan: const drift.Value('Paracetamol 500mg TID'),
        ),
      );

      final draft = await db.consultationDraftDao.getDraftByPatientId('p-001');
      expect(draft, isNotNull);
      expect(draft!.doctorApproved, isFalse);
      expect(draft.subjective, equals('Complains of severe headache'));
    });
  });
}
