import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oms_new/core/localization/app_localizations.dart';
import 'package:oms_new/core/localization/bidi_helper.dart';

void main() {
  group('BidiHelper', () {
    test('isolates Latin text with LRI and PDI markers', () {
      const drugName = 'Augmentin 625mg PO TID';
      final isolated = BidiHelper.isolateLtr(drugName);

      expect(isolated.startsWith(BidiHelper.lri), isTrue);
      expect(isolated.endsWith(BidiHelper.pdi), isTrue);
      expect(isolated, contains(drugName));
    });

    test('formats bilingual prescription line safely', () {
      final formatted = BidiHelper.formatBilingualPrescription(
        arabicPrefix: 'عقار',
        latinDrugNameAndDosage: 'Paracetamol 500mg',
        arabicSuffix: 'قرص كل 8 ساعات',
      );

      expect(formatted, contains('عقار'));
      expect(formatted, contains(BidiHelper.isolateLtr('Paracetamol 500mg')));
      expect(formatted, contains('قرص كل 8 ساعات'));
    });
  });

  group('MedicalTextIsolate widget', () {
    testWidgets('renders text with LTR Directionality', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MedicalTextIsolate('Metformin 1000mg BID'),
          ),
        ),
      );

      final directionality = tester.widget<Directionality>(
        find.descendant(
          of: find.byType(MedicalTextIsolate),
          matching: find.byType(Directionality),
        ),
      );

      expect(directionality.textDirection, equals(TextDirection.ltr));
    });
  });

  group('AppLocalizations', () {
    Widget buildLocalizedWidget(Locale locale, WidgetBuilder builder) {
      return MaterialApp(
        locale: locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Builder(builder: builder),
        ),
      );
    }

    testWidgets('provides Arabic strings and identifies RTL', (tester) async {
      late AppLocalizations localizations;

      await tester.pumpWidget(
        buildLocalizedWidget(const Locale('ar'), (context) {
          localizations = AppLocalizations.of(context);
          return Text(localizations.appTitle);
        }),
      );
      await tester.pumpAndSettle();

      expect(localizations.isRtl, isTrue);
      expect(localizations.appTitle, equals('نظام ون ميديكال - بوابة العيادة'));
      expect(localizations.doctorAssistant, equals('مساعد الطبيب'));
      expect(localizations.treatingDoctor, equals('الطبيب المعالج'));
      expect(
        localizations.unverifiedAiDraft,
        contains('مسودة ذكاء اصطناعي غير معتمدة'),
      );
    });

    testWidgets('provides English strings and identifies LTR', (tester) async {
      late AppLocalizations localizations;

      await tester.pumpWidget(
        buildLocalizedWidget(const Locale('en'), (context) {
          localizations = AppLocalizations.of(context);
          return Text(localizations.appTitle);
        }),
      );
      await tester.pumpAndSettle();

      expect(localizations.isRtl, isFalse);
      expect(localizations.appTitle, equals('One Medical System - Clinic Portal'));
      expect(localizations.doctorAssistant, equals('Doctor Assistant'));
      expect(localizations.treatingDoctor, equals('Treating Doctor'));
      expect(
        localizations.unverifiedAiDraft,
        contains('Unverified AI Draft'),
      );
    });
  });
}
