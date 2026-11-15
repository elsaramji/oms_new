import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oms_new/core/localization/app_localizations.dart';
import 'package:oms_new/features/assistant_intake/domain/entities/patient_summary_entity.dart';
import 'package:oms_new/features/assistant_intake/presentation/cubit/intake_cubit.dart';
import 'package:oms_new/features/assistant_intake/presentation/cubit/intake_state.dart';

class PatientLookupWidget extends StatefulWidget {
  final void Function(PatientSummaryEntity patient) onPatientSelected;
  final VoidCallback onRegisterRequested;

  const PatientLookupWidget({
    super.key,
    required this.onPatientSelected,
    required this.onRegisterRequested,
  });

  @override
  State<PatientLookupWidget> createState() => _PatientLookupWidgetState();
}

class _PatientLookupWidgetState extends State<PatientLookupWidget> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      context.read<IntakeCubit>().searchPatient(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.person_search_rounded, color: Color(0xFF0284C7)),
                const SizedBox(width: 8),
                Text(
                  l10n.searchPatient,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    key: const Key('patient_search_input'),
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Enter 14-digit National ID or Phone (e.g. +2010...)',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onSubmitted: (_) => _onSearch(),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  key: const Key('search_patient_button'),
                  icon: const Icon(Icons.search),
                  label: const Text('Search'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0284C7),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                  onPressed: _onSearch,
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  key: const Key('open_register_patient_button'),
                  icon: const Icon(Icons.person_add),
                  label: Text(l10n.registerPatient),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  onPressed: widget.onRegisterRequested,
                ),
              ],
            ),
            const SizedBox(height: 16),
            BlocConsumer<IntakeCubit, IntakeState>(
              listener: (context, state) {
                if (state is PatientFound) {
                  widget.onPatientSelected(state.patient);
                } else if (state is PatientRegistered) {
                  widget.onPatientSelected(state.patient);
                }
              },
              builder: (context, state) {
                if (state is IntakeLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (state is PatientNotFound) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFBEB),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFFBBF24)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: Color(0xFFD97706)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'No patient found for identifier: "${state.searchedIdentifier}".',
                            style: const TextStyle(color: Color(0xFF92400E)),
                          ),
                        ),
                        TextButton(
                          onPressed: widget.onRegisterRequested,
                          child: Text(l10n.registerPatient),
                        ),
                      ],
                    ),
                  );
                }

                if (state is PatientFound) {
                  final p = state.patient;
                  return _PatientSummaryCard(patient: p);
                }

                if (state is PatientRegistered) {
                  final p = state.patient;
                  return _PatientSummaryCard(patient: p, isNew: true);
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PatientSummaryCard extends StatelessWidget {
  final PatientSummaryEntity patient;
  final bool isNew;

  const _PatientSummaryCard({required this.patient, this.isNew = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF86EFAC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF16A34A)),
              const SizedBox(width: 8),
              Text(
                isNew ? 'Patient Registered Successfully' : 'Patient Found',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF166534),
                ),
              ),
              const Spacer(),
              Chip(
                label: Text(
                  patient.bloodType,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                backgroundColor: const Color(0xFFDC2626).withValues(alpha: 0.1),
                labelStyle: const TextStyle(color: Color(0xFFDC2626)),
              ),
            ],
          ),
          const Divider(),
          Wrap(
            spacing: 24,
            runSpacing: 8,
            children: [
              _infoTile('Full Name', patient.fullName),
              _infoTile('National ID', patient.nationalId),
              _infoTile('Phone', patient.phoneNumber),
              _infoTile('Age', '${patient.age} yrs'),
              _infoTile('Gender', patient.gender),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }
}
