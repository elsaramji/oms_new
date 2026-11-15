import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oms_new/core/localization/app_localizations.dart';
import 'package:oms_new/features/assistant_intake/domain/entities/patient_summary_entity.dart';
import 'package:oms_new/features/assistant_intake/presentation/cubit/intake_cubit.dart';
import 'package:oms_new/features/assistant_intake/presentation/widgets/patient_lookup_widget.dart';
import 'package:oms_new/features/assistant_intake/presentation/widgets/patient_registration_dialog.dart';
import 'package:oms_new/features/assistant_intake/presentation/widgets/vitals_entry_form.dart';
import 'package:oms_new/features/auth/domain/entities/user_entity.dart';
import 'package:oms_new/features/auth/presentation/cubit/auth_cubit.dart';

class AssistantIntakePage extends StatefulWidget {
  final UserEntity currentUser;
  final VoidCallback? onLogout;

  const AssistantIntakePage({
    super.key,
    required this.currentUser,
    this.onLogout,
  });

  @override
  State<AssistantIntakePage> createState() => _AssistantIntakePageState();
}

class _AssistantIntakePageState extends State<AssistantIntakePage> {
  PatientSummaryEntity? _activePatient;

  void _showRegistrationDialog() {
    showDialog(
      context: context,
      builder: (dialogCtx) => BlocProvider.value(
        value: context.read<IntakeCubit>(),
        child: const PatientRegistrationDialog(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            const Icon(Icons.assignment_ind_rounded, color: Color(0xFF0284C7)),
            const SizedBox(width: 8),
            Text(
              '${l10n.patientIntake} - ${widget.currentUser.name}',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xFF64748B)),
            tooltip: 'Logout',
            onPressed: () {
              context.read<AuthCubit>().logout();
              widget.onLogout?.call();
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PatientLookupWidget(
              onPatientSelected: (patient) {
                setState(() {
                  _activePatient = patient;
                });
              },
              onRegisterRequested: _showRegistrationDialog,
            ),
            const SizedBox(height: 24),
            if (_activePatient != null)
              VitalsEntryForm(
                key: ValueKey(_activePatient!.id),
                patient: _activePatient!,
                onDispatched: () {
                  setState(() {
                    _activePatient = null;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}
