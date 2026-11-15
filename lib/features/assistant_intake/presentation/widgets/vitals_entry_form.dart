import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oms_new/core/localization/app_localizations.dart';
import 'package:oms_new/features/assistant_intake/domain/entities/intake_vitals_entity.dart';
import 'package:oms_new/features/assistant_intake/domain/entities/patient_summary_entity.dart';
import 'package:oms_new/features/assistant_intake/presentation/cubit/intake_cubit.dart';
import 'package:oms_new/features/assistant_intake/presentation/cubit/intake_state.dart';

class VitalsEntryForm extends StatefulWidget {
  final PatientSummaryEntity patient;
  final VoidCallback? onDispatched;

  const VitalsEntryForm({
    super.key,
    required this.patient,
    this.onDispatched,
  });

  @override
  State<VitalsEntryForm> createState() => _VitalsEntryFormState();
}

class _VitalsEntryFormState extends State<VitalsEntryForm> {
  final _formKey = GlobalKey<FormState>();
  final _systolicController = TextEditingController(text: '120');
  final _diastolicController = TextEditingController(text: '80');
  final _pulseController = TextEditingController(text: '72');
  final _tempController = TextEditingController(text: '37.0');
  final _spo2Controller = TextEditingController(text: '98');
  final _weightController = TextEditingController(text: '70');
  final _heightController = TextEditingController(text: '175');
  String _priority = 'normal';

  double _computedBmi = 22.9;

  @override
  void initState() {
    super.initState();
    _recalculateBmi();
  }

  @override
  void dispose() {
    _systolicController.dispose();
    _diastolicController.dispose();
    _pulseController.dispose();
    _tempController.dispose();
    _spo2Controller.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _recalculateBmi() {
    final w = double.tryParse(_weightController.text.trim()) ?? 0;
    final h = double.tryParse(_heightController.text.trim()) ?? 0;
    if (w > 0 && h > 0) {
      final hMeters = h / 100.0;
      final bmiVal = w / (hMeters * hMeters);
      setState(() {
        _computedBmi = double.parse(bmiVal.toStringAsFixed(1));
      });
    } else {
      setState(() {
        _computedBmi = 0.0;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final vitals = IntakeVitalsEntity(
        systolicBp: int.tryParse(_systolicController.text.trim()) ?? 0,
        diastolicBp: int.tryParse(_diastolicController.text.trim()) ?? 0,
        pulseRate: int.tryParse(_pulseController.text.trim()) ?? 0,
        temperature: double.tryParse(_tempController.text.trim()) ?? 0.0,
        oxygenSaturation: double.tryParse(_spo2Controller.text.trim()) ?? 0.0,
        weight: double.tryParse(_weightController.text.trim()) ?? 0.0,
        height: double.tryParse(_heightController.text.trim()) ?? 0.0,
        customBmi: _computedBmi,
      );

      context.read<IntakeCubit>().forwardToQueue(
            patient: widget.patient,
            vitals: vitals,
            priority: _priority,
          );
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Icon(Icons.favorite_rounded, color: Color(0xFFEF4444)),
                  const SizedBox(width: 8),
                  Text(
                    '${l10n.vitals} - ${widget.patient.fullName}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0F2FE),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'BMI: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0369A1),
                          ),
                        ),
                        Text(
                          '$_computedBmi kg/m²',
                          key: const Key('bmi_display_text'),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0284C7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      key: const Key('systolic_bp_field'),
                      controller: _systolicController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Systolic BP (mmHg)',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) {
                        final val = int.tryParse(v ?? '');
                        if (val == null || val < 60 || val > 250) {
                          return '60-250 mmHg';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      key: const Key('diastolic_bp_field'),
                      controller: _diastolicController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Diastolic BP (mmHg)',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) {
                        final val = int.tryParse(v ?? '');
                        if (val == null || val < 40 || val > 150) {
                          return '40-150 mmHg';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      key: const Key('pulse_rate_field'),
                      controller: _pulseController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Pulse (bpm)',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) {
                        final val = int.tryParse(v ?? '');
                        if (val == null || val < 35 || val > 220) {
                          return '35-220 bpm';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      key: const Key('temp_field'),
                      controller: _tempController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Temp (°C)',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) {
                        final val = double.tryParse(v ?? '');
                        if (val == null || val < 34.0 || val > 43.0) {
                          return '34.0 - 43.0 °C';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      key: const Key('spo2_field'),
                      controller: _spo2Controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'SpO2 (%)',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) {
                        final val = double.tryParse(v ?? '');
                        if (val == null || val < 60 || val > 100) {
                          return '60-100 %';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      key: const Key('weight_field'),
                      controller: _weightController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Weight (kg)',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (_) => _recalculateBmi(),
                      validator: (v) {
                        final val = double.tryParse(v ?? '');
                        if (val == null || val <= 2 || val > 400) {
                          return '2-400 kg';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      key: const Key('height_field'),
                      controller: _heightController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Height (cm)',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (_) => _recalculateBmi(),
                      validator: (v) {
                        final val = double.tryParse(v ?? '');
                        if (val == null || val <= 30 || val > 250) {
                          return '30-250 cm';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    'Queue Priority: ',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('Normal'),
                    selected: _priority == 'normal',
                    onSelected: (sel) {
                      if (sel) setState(() => _priority = 'normal');
                    },
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('Urgent'),
                    selectedColor: const Color(0xFFFEE2E2),
                    labelStyle: TextStyle(
                      color: _priority == 'urgent'
                          ? const Color(0xFFDC2626)
                          : Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                    selected: _priority == 'urgent',
                    onSelected: (sel) {
                      if (sel) setState(() => _priority = 'urgent');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              BlocConsumer<IntakeCubit, IntakeState>(
                listener: (context, state) {
                  if (state is IntakeDispatchedToQueue) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${widget.patient.fullName} successfully forwarded to doctor queue!',
                        ),
                        backgroundColor: const Color(0xFF16A34A),
                      ),
                    );
                    widget.onDispatched?.call();
                  } else if (state is IntakeError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: const Color(0xFFDC2626),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  final isDispatching = state is IntakeLoading;

                  return ElevatedButton.icon(
                    key: const Key('forward_to_queue_button'),
                    icon: const Icon(Icons.send_rounded),
                    label: isDispatching
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(l10n.forwardToQueue),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF16A34A),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: isDispatching ? null : _submit,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
