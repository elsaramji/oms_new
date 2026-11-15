import 'package:flutter/material.dart';
import 'package:oms_new/core/localization/bidi_helper.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/ai_draft_note_entity.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/prescription_entity.dart';

class SoapNoteEditorWidget extends StatefulWidget {
  final AiDraftNoteEntity draft;
  final void Function({
    String? subjective,
    String? objective,
    String? assessment,
    String? plan,
  }) onSoapChanged;
  final void Function(PrescriptionEntity prescription) onAddPrescription;
  final void Function(String prescriptionId) onRemovePrescription;

  const SoapNoteEditorWidget({
    super.key,
    required this.draft,
    required this.onSoapChanged,
    required this.onAddPrescription,
    required this.onRemovePrescription,
  });

  @override
  State<SoapNoteEditorWidget> createState() => _SoapNoteEditorWidgetState();
}

class _SoapNoteEditorWidgetState extends State<SoapNoteEditorWidget> {
  late TextEditingController _subjectiveController;
  late TextEditingController _objectiveController;
  late TextEditingController _assessmentController;
  late TextEditingController _planController;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _subjectiveController = TextEditingController(text: widget.draft.subjective);
    _objectiveController = TextEditingController(text: widget.draft.objective);
    _assessmentController = TextEditingController(text: widget.draft.assessment);
    _planController = TextEditingController(text: widget.draft.plan);
  }

  @override
  void didUpdateWidget(covariant SoapNoteEditorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.draft.id != widget.draft.id ||
        (oldWidget.draft.isAiGenerated != widget.draft.isAiGenerated &&
            widget.draft.isAiGenerated)) {
      _subjectiveController.text = widget.draft.subjective;
      _objectiveController.text = widget.draft.objective;
      _assessmentController.text = widget.draft.assessment;
      _planController.text = widget.draft.plan;
    }
  }

  @override
  void dispose() {
    _subjectiveController.dispose();
    _objectiveController.dispose();
    _assessmentController.dispose();
    _planController.dispose();
    super.dispose();
  }

  void _showAddPrescriptionDialog() {
    final nameCtrl = TextEditingController();
    final dosageCtrl = TextEditingController(text: '500mg');
    final freqCtrl = TextEditingController(text: 'TID');
    final durCtrl = TextEditingController(text: '5 days');
    final instCtrl = TextEditingController(text: 'After meals');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.medication_rounded, color: Color(0xFF0284C7)),
            SizedBox(width: 8),
            Text('Add Medication / Therapy'),
          ],
        ),
        content: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                key: const Key('rx_name_input'),
                controller: nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Medication Name (e.g. Paracetamol)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      key: const Key('rx_dosage_input'),
                      controller: dosageCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Dosage (e.g. 500mg)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      key: const Key('rx_freq_input'),
                      controller: freqCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Frequency (e.g. TID)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      key: const Key('rx_duration_input'),
                      controller: durCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Duration (e.g. 5 days)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      key: const Key('rx_instructions_input'),
                      controller: instCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Instructions',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            key: const Key('submit_add_rx_button'),
            onPressed: () {
              if (nameCtrl.text.trim().isNotEmpty) {
                widget.onAddPrescription(
                  PrescriptionEntity(
                    id: 'rx-${DateTime.now().millisecondsSinceEpoch}',
                    medicationName: nameCtrl.text.trim(),
                    dosage: dosageCtrl.text.trim(),
                    frequency: freqCtrl.text.trim(),
                    duration: durCtrl.text.trim(),
                    instructions: instCtrl.text.trim(),
                  ),
                );
                Navigator.of(ctx).pop();
              }
            },
            child: const Text('Add to Regimen'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSoapField(
          key: const Key('soap_subjective_field'),
          label: 'S - Subjective (History of Present Illness & Symptoms)',
          controller: _subjectiveController,
          hint: 'Enter patient history, complaints, and timeline...',
          onChanged: (v) => widget.onSoapChanged(subjective: v),
        ),
        const SizedBox(height: 14),
        _buildSoapField(
          key: const Key('soap_objective_field'),
          label: 'O - Objective (Physical Findings & Intake Vitals)',
          controller: _objectiveController,
          hint: 'Document physical exam findings, systemic observations...',
          onChanged: (v) => widget.onSoapChanged(objective: v),
        ),
        const SizedBox(height: 14),
        _buildSoapField(
          key: const Key('soap_assessment_field'),
          label: 'A - Assessment (Clinical Impression & Diagnoses)',
          controller: _assessmentController,
          hint: 'Document clinical diagnosis, differential diagnosis...',
          onChanged: (v) => widget.onSoapChanged(assessment: v),
        ),
        const SizedBox(height: 14),
        _buildSoapField(
          key: const Key('soap_plan_field'),
          label: 'P - Plan (Counseling & Follow-up Instructions)',
          controller: _planController,
          hint: 'Patient education, follow-up timeline, warning signs...',
          onChanged: (v) => widget.onSoapChanged(plan: v),
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Proposed Prescription Regimens (E-Rx)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF0F172A),
              ),
            ),
            TextButton.icon(
              key: const Key('add_prescription_button'),
              icon: const Icon(Icons.add_circle_outline, size: 18),
              label: const Text('Add Medication'),
              onPressed: _showAddPrescriptionDialog,
            ),
          ],
        ),
        const SizedBox(height: 6),
        if (widget.draft.prescriptions.isEmpty)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const Text(
              'No medications added yet. Prescribe medications above or generate via AI Scribe.',
              style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.draft.prescriptions.length,
            separatorBuilder: (_, __) => const SizedBox(height: 6),
            itemBuilder: (context, index) {
              final rx = widget.draft.prescriptions[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.medication, size: 18, color: Color(0xFF0284C7)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MedicalTextIsolate(
                            '${rx.medicationName} ${rx.dosage} (${rx.frequency}) x ${rx.duration}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          if (rx.instructions.isNotEmpty)
                            Text(
                              rx.instructions,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF64748B),
                              ),
                            ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 16, color: Colors.red),
                      tooltip: 'Remove',
                      onPressed: () => widget.onRemovePrescription(rx.id),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildSoapField({
    required Key key,
    required String label,
    required TextEditingController controller,
    required String hint,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          key: key,
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.all(12),
            border: const OutlineInputBorder(),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
