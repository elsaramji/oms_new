import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oms_new/core/localization/bidi_helper.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/entities/ehr_timeline_entity.dart';
import 'package:oms_new/features/doctor_queue_ehr/presentation/widgets/high_contrast_alert_banner.dart';

class LongitudinalEhrTimelineWidget extends StatelessWidget {
  final EhrTimelineEntity? ehrTimeline;
  final bool isLoading;

  const LongitudinalEhrTimelineWidget({
    super.key,
    required this.ehrTimeline,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (ehrTimeline == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Select a patient from the queue to inspect longitudinal EHR history.',
            style: TextStyle(color: Color(0xFF64748B)),
          ),
        ),
      );
    }

    final timeline = ehrTimeline!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HighContrastAlertBanner(
            allergies: timeline.allergies,
            chronicConditions: timeline.chronicConditions,
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.history_edu_rounded, color: Color(0xFF0284C7)),
              SizedBox(width: 8),
              Text(
                'Longitudinal Clinical Encounters',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (timeline.records.isEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: const Text('No prior medical visits recorded for this patient.'),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: timeline.records.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final visit = timeline.records[index];
                return Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              size: 16,
                              color: Color(0xFF0284C7),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              DateFormat('dd MMM yyyy, hh:mm a')
                                  .format(visit.visitDate),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              visit.attendingDoctor,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Chief Complaint: ${visit.chiefComplaint}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF334155),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Diagnosis: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                visit.diagnosis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF0284C7),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (visit.prescriptions.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          const Text(
                            'Therapies / Prescriptions:',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475569),
                            ),
                          ),
                          const SizedBox(height: 4),
                          ...visit.prescriptions.map((rx) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 8, top: 2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('• ',
                                      style: TextStyle(color: Color(0xFF0284C7))),
                                  Expanded(
                                    child: MedicalTextIsolate(
                                      rx,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'monospace',
                                        color: Color(0xFF334155),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
