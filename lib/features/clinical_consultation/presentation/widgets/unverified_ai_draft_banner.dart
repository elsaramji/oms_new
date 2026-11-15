import 'package:flutter/material.dart';
import 'package:oms_new/core/localization/app_localizations.dart';

class UnverifiedAiDraftBanner extends StatelessWidget {
  final bool isApproved;
  final ValueChanged<bool> onApprovalChanged;

  const UnverifiedAiDraftBanner({
    super.key,
    required this.isApproved,
    required this.onApprovalChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (isApproved) {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF0FDF4),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF86EFAC)),
        ),
        child: Row(
          children: [
            const Icon(Icons.verified_user_rounded, color: Color(0xFF16A34A)),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Clinical notes and prescription regimens verified and approved by treating doctor.',
                style: TextStyle(
                  color: Color(0xFF166534),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
            TextButton(
              onPressed: () => onApprovalChanged(false),
              child: const Text('Revoke Approval', style: TextStyle(color: Color(0xFFDC2626))),
            ),
          ],
        ),
      );
    }

    return Container(
      key: const Key('unverified_ai_draft_banner'),
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3C7), // Amber
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFF59E0B), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.gavel_rounded,
                color: Color(0xFFB45309),
                size: 24,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n.unverifiedAiDraft,
                  style: const TextStyle(
                    color: Color(0xFF92400E),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          InkWell(
            key: const Key('doctor_approval_checkbox_tap'),
            onTap: () => onApprovalChanged(!isApproved),
            borderRadius: BorderRadius.circular(6),
            child: Row(
              children: [
                Checkbox(
                  key: const Key('doctor_approval_checkbox'),
                  value: isApproved,
                  activeColor: const Color(0xFF16A34A),
                  onChanged: (val) => onApprovalChanged(val ?? false),
                ),
                const Expanded(
                  child: Text(
                    'I certify that I have thoroughly reviewed the clinical note details, '
                    'vital findings, and drug regimens, and approve this consultation record.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF78350F),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
