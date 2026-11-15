import 'package:flutter/material.dart';
import 'package:oms_new/core/localization/app_localizations.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/entities/allergy_alert_entity.dart';

class HighContrastAlertBanner extends StatelessWidget {
  final List<AllergyAlertEntity> allergies;
  final List<String> chronicConditions;

  const HighContrastAlertBanner({
    super.key,
    required this.allergies,
    required this.chronicConditions,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final severeAllergies = allergies.where((a) => a.isSevere).toList();

    if (allergies.isEmpty && chronicConditions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (severeAllergies.isNotEmpty)
          Container(
            key: const Key('severe_allergy_alert_banner'),
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFDC2626), // High-contrast Red
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.white,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CRITICAL SAFETY WARNING: SEVERE ALLERGIES RECORDED',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: severeAllergies.map((a) {
                          return Text(
                            '• ${a.allergen} (${a.reaction})',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        if (chronicConditions.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFBEB), // Amber tint
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFFDE68A)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.health_and_safety_outlined,
                  color: Color(0xFFD97706),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '${l10n.chronicConditions}:',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF92400E),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: chronicConditions.map((condition) {
                      return Chip(
                        label: Text(
                          condition,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF78350F),
                          ),
                        ),
                        backgroundColor: const Color(0xFFFEF3C7),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
