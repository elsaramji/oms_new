import 'package:oms_new/core/database/daos/queue_dao.dart';
import 'package:oms_new/features/doctor_queue_ehr/data/models/ehr_models.dart';
import 'package:oms_new/features/doctor_queue_ehr/data/models/queue_patient_model.dart';

abstract class DoctorQueueDataSource {
  Stream<List<QueuePatientModel>> watchWaitingQueue();
  Future<EhrTimelineModel> getPatientEhr(String patientId);
  Future<void> updateQueueStatus(String queueId, String status);
}

class DoctorQueueDataSourceImpl implements DoctorQueueDataSource {
  final QueueDao queueDao;

  DoctorQueueDataSourceImpl(this.queueDao);

  @override
  Stream<List<QueuePatientModel>> watchWaitingQueue() {
    return queueDao.watchWaitingQueue().map((rows) {
      return rows.map((r) => QueuePatientModel.fromRow(r)).toList();
    });
  }

  @override
  Future<EhrTimelineModel> getPatientEhr(String patientId) async {
    await Future.delayed(const Duration(milliseconds: 30));

    // Realistic seeded EHR longitudinal timeline with safety alerts
    return EhrTimelineModel(
      patientId: patientId,
      allergies: const [
        AllergyAlertModel(
          allergen: 'Penicillin',
          severity: 'Severe',
          reaction: 'Anaphylaxis and acute bronchospasm',
        ),
        AllergyAlertModel(
          allergen: 'NSAIDs',
          severity: 'Moderate',
          reaction: 'Urticaria & facial angioedema',
        ),
      ],
      chronicConditions: const [
        'Type 2 Diabetes Mellitus',
        'Essential Hypertension',
      ],
      records: [
        MedicalRecordModel(
          visitId: 'vis-002',
          visitDate: DateTime.now().subtract(const Duration(days: 45)),
          attendingDoctor: 'د. طارق عمر (Dr. Tarek Omar)',
          chiefComplaint: 'Follow-up for glycemic and blood pressure control',
          diagnosis: 'Type 2 Diabetes - HbA1c 7.4% & Stage 1 HTN',
          prescriptions: const [
            'Metformin 1000mg PO BID with meals',
            'Amlodipine 5mg PO OD morning',
          ],
        ),
        MedicalRecordModel(
          visitId: 'vis-001',
          visitDate: DateTime.now().subtract(const Duration(days: 120)),
          attendingDoctor: 'د. طارق عمر (Dr. Tarek Omar)',
          chiefComplaint: 'Acute pharyngitis, cough, and fever',
          diagnosis: 'Acute Viral Pharyngitis (No antibiotic warranted)',
          prescriptions: const [
            'Paracetamol 1000mg PO PRN q8h (Max 4g/day)',
            'Warm saline gargles TID',
          ],
        ),
      ],
    );
  }

  @override
  Future<void> updateQueueStatus(String queueId, String status) async {
    await queueDao.updateQueueStatus(queueId, status);
  }
}
