import 'package:flutter/material.dart';

class BidiHelper {
  /// Left-to-Right Isolate (LRI)
  static const String lri = '\u2066';

  /// Pop Directional Isolate (PDI)
  static const String pdi = '\u2069';

  /// Right-to-Left Isolate (RLI)
  static const String rli = '\u2067';

  /// First Strong Isolate (FSI)
  static const String fsi = '\u2068';

  /// Wraps Latin clinical formulas, drug names, and dosages (e.g. 'Amoxicillin 500mg TID')
  /// in LTR Unicode isolates to ensure correct rendering inside Arabic RTL texts.
  static String isolateLtr(String text) {
    if (text.isEmpty) return text;
    return '$lri$text$pdi';
  }

  /// Wraps Arabic phrases in RTL Unicode isolates inside LTR texts.
  static String isolateRtl(String text) {
    if (text.isEmpty) return text;
    return '$rli$text$pdi';
  }

  /// Formats medical prescription line with isolation
  /// e.g. "أقراص Paracetamol 500mg مرتين يومياً"
  static String formatBilingualPrescription({
    required String arabicPrefix,
    required String latinDrugNameAndDosage,
    required String arabicSuffix,
  }) {
    return '$arabicPrefix ${isolateLtr(latinDrugNameAndDosage)} $arabicSuffix'.trim();
  }
}

/// A widget that safely isolates medical prescription or clinical terms into LTR direction
class MedicalTextIsolate extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const MedicalTextIsolate(
    this.text, {
    super.key,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
