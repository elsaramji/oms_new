import 'package:equatable/equatable.dart';

class IntakeVitalsEntity extends Equatable {
  final int systolicBp;
  final int diastolicBp;
  final int pulseRate;
  final double temperature;
  final double oxygenSaturation;
  final double weight;
  final double height;
  final double? customBmi;

  const IntakeVitalsEntity({
    required this.systolicBp,
    required this.diastolicBp,
    required this.pulseRate,
    required this.temperature,
    required this.oxygenSaturation,
    required this.weight,
    required this.height,
    this.customBmi,
  });

  /// Automatically computes Body Mass Index (BMI = kg / m^2) rounded to 1 decimal place
  double get bmi {
    if (customBmi != null) return customBmi!;
    if (height <= 0 || weight <= 0) return 0.0;
    final heightInMeters = height / 100.0;
    final rawBmi = weight / (heightInMeters * heightInMeters);
    return double.parse(rawBmi.toStringAsFixed(1));
  }

  /// Validates physiological limits
  bool get isValid {
    return systolicBp > 50 &&
        systolicBp <= 250 &&
        diastolicBp > 30 &&
        diastolicBp <= 150 &&
        pulseRate > 30 &&
        pulseRate <= 220 &&
        temperature >= 34.0 &&
        temperature <= 43.0 &&
        oxygenSaturation >= 60.0 &&
        oxygenSaturation <= 100.0 &&
        weight > 2.0 &&
        weight <= 400.0 &&
        height > 30.0 &&
        height <= 250.0;
  }

  @override
  List<Object?> get props => [
        systolicBp,
        diastolicBp,
        pulseRate,
        temperature,
        oxygenSaturation,
        weight,
        height,
        customBmi,
      ];
}
