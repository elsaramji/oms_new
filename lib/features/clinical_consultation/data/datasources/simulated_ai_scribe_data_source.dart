import 'package:oms_new/features/clinical_consultation/data/models/consultation_draft_model.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/ai_draft_note_entity.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/prescription_entity.dart';

abstract class SimulatedAiScribeDataSource {
  Future<ConsultationDraftModel> generateSoapDraft(String patientId);
}

class SimulatedAiScribeDataSourceImpl implements SimulatedAiScribeDataSource {
  @override
  Future<ConsultationDraftModel> generateSoapDraft(String patientId) async {
    // Simulates realistic audio processing latency
    await Future.delayed(const Duration(milliseconds: 60));

    return ConsultationDraftModel(
      id: 'draft-${DateTime.now().millisecondsSinceEpoch}',
      patientId: patientId,
      subjective:
          'Patient presents with a 4-day history of sharp burning epigastric discomfort '
          'radiating retrosternally, exacerbated postprandially (particularly after spicy food) '
          'and relieved partially by milk. Denies hematemesis, melena, or dysphagia. '
          'Patient reminds of severe allergy to Penicillin.',
      objective:
          'General: Alert, mildly uncomfortable.\n'
          'Vitals: BP 122/80 mmHg, HR 74 bpm, Temp 36.9°C, SpO2 99% on room air.\n'
          'Abdomen: Soft, non-distended, moderate focal tenderness elicited upon deep '
          'palpation in epigastric region. No rebound tenderness, guarding, or organomegaly.',
      assessment:
          '1. Acute Non-Ulcer Dyspepsia (ICD-10: K30) vs Gastroesophageal Reflux Disease (GERD).\n'
          '2. Well-controlled Essential Hypertension (ICD-10: I10).\n'
          '3. Documented Severe Penicillin Allergy (Avoid all beta-lactams).',
      plan:
          '1. Dietary counseling: Avoid fried, acidic foods, caffeine, and late night meals.\n'
          '2. Medical therapy: Initiate proton-pump inhibitor and antacid.\n'
          '3. H. pylori stool antigen test if symptoms persist beyond 2 weeks.\n'
          '4. Red flag education: Return immediately if experiencing tarry stools or vomiting.',
      prescriptions: const [
        PrescriptionEntity(
          id: 'rx-ai-1',
          medicationName: 'Omeprazole',
          dosage: '20mg',
          frequency: 'PO Once Daily (OD)',
          duration: '14 days',
          instructions: 'Take 30 minutes before breakfast on an empty stomach',
        ),
        PrescriptionEntity(
          id: 'rx-ai-2',
          medicationName: 'Magnesium / Aluminum Hydroxide Gel',
          dosage: '15ml',
          frequency: 'PO TID PC & QHS',
          duration: '7 days',
          instructions: 'Take 1 hour after meals and before bedtime as needed',
        ),
      ],
      reviewStatus: DraftReviewStatus.draft,
      doctorApproved: false, // Critical HITL safety invariant: initialized unapproved
      isAiGenerated: true,
      updatedAt: DateTime.now(),
    );
  }
}
