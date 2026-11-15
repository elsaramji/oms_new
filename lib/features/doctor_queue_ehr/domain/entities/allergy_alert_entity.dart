import 'package:equatable/equatable.dart';

class AllergyAlertEntity extends Equatable {
  final String allergen;
  final String severity; // High, Moderate, Severe
  final String reaction;

  const AllergyAlertEntity({
    required this.allergen,
    required this.severity,
    required this.reaction,
  });

  bool get isSevere =>
      severity.toLowerCase() == 'severe' || severity.toLowerCase() == 'high';

  @override
  List<Object?> get props => [allergen, severity, reaction];
}
