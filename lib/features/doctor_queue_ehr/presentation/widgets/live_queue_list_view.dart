import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oms_new/core/localization/app_localizations.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/entities/queue_patient_entity.dart';

class LiveQueueListView extends StatelessWidget {
  final List<QueuePatientEntity> patients;
  final QueuePatientEntity? selectedPatient;
  final void Function(QueuePatientEntity patient) onPatientSelected;

  const LiveQueueListView({
    super.key,
    required this.patients,
    required this.selectedPatient,
    required this.onPatientSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    if (patients.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.people_outline, size: 56, color: Colors.grey.shade400),
              const SizedBox(height: 12),
              Text(
                'No patients waiting in queue',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'New patients dispatched by assistant will appear here in real time.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: patients.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final item = patients[index];
        final isSelected = selectedPatient?.id == item.id;
        final isUrgent = item.isUrgent;

        return Card(
          elevation: isSelected ? 4 : 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: isSelected
                  ? const Color(0xFF0284C7)
                  : isUrgent
                      ? const Color(0xFFFCA5A5)
                      : Colors.grey.shade200,
              width: isSelected ? 2 : 1,
            ),
          ),
          color: isSelected ? const Color(0xFFF0F9FF) : Colors.white,
          child: InkWell(
            key: Key('queue_patient_item_${item.id}'),
            borderRadius: BorderRadius.circular(10),
            onTap: () => onPatientSelected(item),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF0284C7)
                              : const Color(0xFFE2E8F0),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '#${item.queueNumber}',
                            style: TextStyle(
                              color: isSelected ? Colors.white : const Color(0xFF334155),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.patientName,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              'Arrived ${DateFormat('hh:mm a').format(item.forwardedAt)}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isUrgent)
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEE2E2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'URGENT',
                            style: TextStyle(
                              color: Color(0xFFDC2626),
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (item.vitals != null) ...[
                    const SizedBox(height: 10),
                    const Divider(height: 1),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 12,
                      runSpacing: 4,
                      children: [
                        _vitalChip(
                          'BP',
                          '${item.vitals!.systolicBp}/${item.vitals!.diastolicBp}',
                        ),
                        _vitalChip('Pulse', '${item.vitals!.pulseRate} bpm'),
                        _vitalChip('Temp', '${item.vitals!.temperature}°C'),
                        _vitalChip('BMI', '${item.vitals!.bmi}'),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _vitalChip(String label, String value) {
    return Text(
      '$label: $value',
      style: const TextStyle(
        fontSize: 11,
        color: Color(0xFF475569),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
