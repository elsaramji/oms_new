import 'package:equatable/equatable.dart';

class PrescriptionEntity extends Equatable {
  final String id;
  final String medicationName;
  final String dosage;
  final String frequency;
  final String duration;
  final String instructions;

  const PrescriptionEntity({
    required this.id,
    required this.medicationName,
    required this.dosage,
    required this.frequency,
    required this.duration,
    this.instructions = '',
  });

  String get formattedRegimen => '$medicationName $dosage $frequency x $duration';

  @override
  List<Object?> get props => [
        id,
        medicationName,
        dosage,
        frequency,
        duration,
        instructions,
      ];
}
