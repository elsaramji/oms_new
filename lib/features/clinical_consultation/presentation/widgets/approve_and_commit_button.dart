import 'package:flutter/material.dart';
import 'package:oms_new/core/localization/app_localizations.dart';

class ApproveAndCommitButton extends StatelessWidget {
  final bool isApproved;
  final bool isCommitting;
  final VoidCallback onCommit;

  const ApproveAndCommitButton({
    super.key,
    required this.isApproved,
    required this.isCommitting,
    required this.onCommit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ElevatedButton.icon(
      key: const Key('approve_and_commit_button'),
      icon: isCommitting
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : const Icon(Icons.check_circle_outline),
      label: Text(
        l10n.approveAndCommit,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isApproved ? const Color(0xFF16A34A) : Colors.grey.shade400,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: isCommitting ? null : onCommit,
    );
  }
}
