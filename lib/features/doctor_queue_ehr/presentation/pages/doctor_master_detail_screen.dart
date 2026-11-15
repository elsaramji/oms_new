import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oms_new/core/localization/app_localizations.dart';
import 'package:oms_new/core/responsive/responsive_layout.dart';
import 'package:oms_new/features/auth/domain/entities/user_entity.dart';
import 'package:oms_new/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:oms_new/features/clinical_consultation/presentation/cubit/consultation_cubit.dart';
import 'package:oms_new/features/clinical_consultation/presentation/cubit/consultation_state.dart';
import 'package:oms_new/features/clinical_consultation/presentation/widgets/approve_and_commit_button.dart';
import 'package:oms_new/features/clinical_consultation/presentation/widgets/qr_prescription_dialog.dart';
import 'package:oms_new/features/clinical_consultation/presentation/widgets/simulated_scribe_audio_widget.dart';
import 'package:oms_new/features/clinical_consultation/presentation/widgets/soap_note_editor_widget.dart';
import 'package:oms_new/features/clinical_consultation/presentation/widgets/unverified_ai_draft_banner.dart';
import 'package:oms_new/features/doctor_queue_ehr/domain/entities/queue_patient_entity.dart';
import 'package:oms_new/features/doctor_queue_ehr/presentation/cubit/doctor_queue_cubit.dart';
import 'package:oms_new/features/doctor_queue_ehr/presentation/cubit/doctor_queue_state.dart';
import 'package:oms_new/features/doctor_queue_ehr/presentation/widgets/live_queue_list_view.dart';
import 'package:oms_new/features/doctor_queue_ehr/presentation/widgets/longitudinal_ehr_timeline_widget.dart';

class DoctorMasterDetailScreen extends StatefulWidget {
  final UserEntity currentDoctor;
  final VoidCallback? onLogout;

  const DoctorMasterDetailScreen({
    super.key,
    required this.currentDoctor,
    this.onLogout,
  });

  @override
  State<DoctorMasterDetailScreen> createState() =>
      _DoctorMasterDetailScreenState();
}

class _DoctorMasterDetailScreenState extends State<DoctorMasterDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _panelATabController;

  @override
  void initState() {
    super.initState();
    _panelATabController = TabController(length: 2, vsync: this);
    context.read<DoctorQueueCubit>().startQueueSubscription();
  }

  @override
  void dispose() {
    _panelATabController.dispose();
    super.dispose();
  }

  void _onPatientSelected(QueuePatientEntity patient) {
    context.read<DoctorQueueCubit>().selectPatient(patient);
    context.read<ConsultationCubit>().initDraftForPatient(patient.patientId);
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
            const Icon(Icons.local_hospital_rounded, color: Color(0xFF0284C7)),
            const SizedBox(width: 8),
            Text(
              '${l10n.treatingDoctor} Workspace - ${widget.currentDoctor.name}',
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
      body: BlocConsumer<ConsultationCubit, ConsultationState>(
        listener: (context, state) {
          if (state is ConsultationCommitted) {
            showDialog(
              context: context,
              builder: (_) => QrPrescriptionDialog(prescription: state.prescriptionQr),
            );
          } else if (state is ConsultationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFDC2626),
              ),
            );
          }
        },
        builder: (context, consultationState) {
          return BlocBuilder<DoctorQueueCubit, DoctorQueueState>(
            builder: (context, queueState) {
              final queuePatients = (queueState is DoctorQueueLoaded)
                  ? queueState.queuePatients
                  : <QueuePatientEntity>[];
              final selectedPatient = (queueState is DoctorQueueLoaded)
                  ? queueState.selectedPatient
                  : null;
              final selectedEhr = (queueState is DoctorQueueLoaded)
                  ? queueState.selectedPatientEhr
                  : null;
              final isLoadingEhr = (queueState is DoctorQueueLoaded)
                  ? queueState.isLoadingEhr
                  : false;

              return ResponsiveLayoutBuilder(
                desktop: (context, constraints) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Panel A: Queue & EHR (35% width)
                      SizedBox(
                        width: constraints.maxWidth * 0.35,
                        child: _buildPanelA(
                          queuePatients: queuePatients,
                          selectedPatient: selectedPatient,
                          selectedEhr: selectedEhr,
                          isLoadingEhr: isLoadingEhr,
                        ),
                      ),
                      const VerticalDivider(width: 1),
                      // Panel B: Clinical Consultation & HITL Gate (65% width)
                      Expanded(
                        child: _buildPanelB(
                          selectedPatient: selectedPatient,
                          consultationState: consultationState,
                        ),
                      ),
                    ],
                  );
                },
                tablet: (context, constraints) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Panel A on tablet (40% width)
                      SizedBox(
                        width: constraints.maxWidth * 0.40,
                        child: _buildPanelA(
                          queuePatients: queuePatients,
                          selectedPatient: selectedPatient,
                          selectedEhr: selectedEhr,
                          isLoadingEhr: isLoadingEhr,
                        ),
                      ),
                      const VerticalDivider(width: 1),
                      // Panel B on tablet (60% width)
                      Expanded(
                        child: _buildPanelB(
                          selectedPatient: selectedPatient,
                          consultationState: consultationState,
                        ),
                      ),
                    ],
                  );
                },
                mobile: (context, constraints) {
                  return _buildPanelB(
                    selectedPatient: selectedPatient,
                    consultationState: consultationState,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildPanelA({
    required List<QueuePatientEntity> queuePatients,
    required QueuePatientEntity? selectedPatient,
    required dynamic selectedEhr,
    required bool isLoadingEhr,
  }) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          TabBar(
            controller: _panelATabController,
            labelColor: const Color(0xFF0284C7),
            unselectedLabelColor: const Color(0xFF64748B),
            indicatorColor: const Color(0xFF0284C7),
            tabs: [
              Tab(
                icon: const Icon(Icons.format_list_numbered_rounded),
                text: 'Live Queue (${queuePatients.length})',
              ),
              Tab(
                icon: const Icon(Icons.history_edu),
                text: selectedPatient != null
                    ? '${selectedPatient.patientName} EHR'
                    : 'Patient EHR',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _panelATabController,
              children: [
                LiveQueueListView(
                  patients: queuePatients,
                  selectedPatient: selectedPatient,
                  onPatientSelected: (p) {
                    _onPatientSelected(p);
                    _panelATabController.animateTo(1); // Switch to EHR tab
                  },
                ),
                LongitudinalEhrTimelineWidget(
                  ehrTimeline: selectedEhr,
                  isLoading: isLoadingEhr,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPanelB({
    required QueuePatientEntity? selectedPatient,
    required ConsultationState consultationState,
  }) {
    if (selectedPatient == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.touch_app_outlined, size: 64, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              const Text(
                'No Active Patient Selected',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF334155),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Click any patient from the waiting queue on the left to start consultation.',
                style: TextStyle(color: Color(0xFF64748B)),
              ),
            ],
          ),
        ),
      );
    }

    if (consultationState is ConsultationLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (consultationState is! ConsultationDraftLoaded) {
      return const SizedBox.shrink();
    }

    final draftState = consultationState;
    final draft = draftState.draft;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Active Patient Context Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFFE0F2FE),
                  child: Text(
                    selectedPatient.patientName.isNotEmpty
                        ? selectedPatient.patientName[0].toUpperCase()
                        : 'P',
                    style: const TextStyle(
                      color: Color(0xFF0369A1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedPatient.patientName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      if (selectedPatient.vitals != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          'BP: ${selectedPatient.vitals!.systolicBp}/${selectedPatient.vitals!.diastolicBp} mmHg  •  '
                          'Pulse: ${selectedPatient.vitals!.pulseRate} bpm  •  '
                          'Temp: ${selectedPatient.vitals!.temperature}°C  •  '
                          'BMI: ${selectedPatient.vitals!.bmi}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF475569),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                SimulatedScribeAudioWidget(
                  isGenerating: draftState.isGeneratingScribe,
                  onTriggerScribe: () {
                    context
                        .read<ConsultationCubit>()
                        .generateAiScribe(selectedPatient.patientId);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Unverified AI Draft Safety Banner & HITL Approval Checkbox
          UnverifiedAiDraftBanner(
            isApproved: draft.doctorApproved,
            onApprovalChanged: (approved) {
              context.read<ConsultationCubit>().setDoctorApproval(approved);
            },
          ),
          // SOAP Note Editor & Prescriptions
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SoapNoteEditorWidget(
                draft: draft,
                onSoapChanged: ({subjective, objective, assessment, plan}) {
                  context.read<ConsultationCubit>().updateSoapFields(
                        subjective: subjective,
                        objective: objective,
                        assessment: assessment,
                        plan: plan,
                      );
                },
                onAddPrescription: (rx) {
                  context.read<ConsultationCubit>().addPrescription(rx);
                },
                onRemovePrescription: (rxId) {
                  context.read<ConsultationCubit>().removePrescription(rxId);
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Commit Button with Safety Invariant
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ApproveAndCommitButton(
                isApproved: draft.doctorApproved,
                isCommitting: draftState.isCommitting,
                onCommit: () {
                  context.read<ConsultationCubit>().commitConsultation(
                        patientName: selectedPatient.patientName,
                        doctorName: widget.currentDoctor.name,
                      );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
