import 'package:oms_new/features/assistant_intake/domain/entities/intake_vitals_entity.dart';

class IntakeVitalsModel extends IntakeVitalsEntity {
  const IntakeVitalsModel({
    required super.systolicBp,
    required super.diastolicBp,
    required super.pulseRate,
    required super.temperature,
    required super.oxygenSaturation,
    required super.weight,
    required super.height,
    super.customBmi,
  });

  factory IntakeVitalsModel.fromEntity(IntakeVitalsEntity entity) {
    return IntakeVitalsModel(
      systolicBp: entity.systolicBp,
      diastolicBp: entity.diastolicBp,
      pulseRate: entity.pulseRate,
      temperature: entity.temperature,
      oxygenSaturation: entity.oxygenSaturation,
      weight: entity.weight,
      height: entity.height,
      customBmi: entity.bmi,
    );
  }

  factory IntakeVitalsModel.fromJson(Map<String, dynamic> json) {
    return IntakeVitalsModel(
      systolicBp: json['systolicBp'] as int,
      diastolicBp: json['diastolicBp'] as int,
      pulseRate: json['pulseRate'] as int,
      temperature: (json['temperature'] as num).toDouble(),
      oxygenSaturation: (json['oxygenSaturation'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      customBmi: (json['bmi'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'systolicBp': systolicBp,
      'diastolicBp': diastolicBp,
      'pulseRate': pulseRate,
      'temperature': temperature,
      'oxygenSaturation': oxygenSaturation,
      'weight': weight,
      'height': height,
      'bmi': bmi,
    };
  }
}
