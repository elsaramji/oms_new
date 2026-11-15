import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oms_new/core/responsive/responsive_layout.dart';

void main() {
  group('ResponsiveBreakpoints', () {
    test('classifies widths correctly into DeviceTypes', () {
      expect(ResponsiveBreakpoints.getDeviceType(1440), equals(DeviceType.desktop));
      expect(ResponsiveBreakpoints.getDeviceType(1200), equals(DeviceType.desktop));
      expect(ResponsiveBreakpoints.getDeviceType(1199), equals(DeviceType.tablet));
      expect(ResponsiveBreakpoints.getDeviceType(768), equals(DeviceType.tablet));
      expect(ResponsiveBreakpoints.getDeviceType(767), equals(DeviceType.mobile));
      expect(ResponsiveBreakpoints.getDeviceType(400), equals(DeviceType.mobile));
    });
  });

  group('ResponsiveLayoutBuilder widget', () {
    Widget buildTestWidget() {
      return MaterialApp(
        home: Scaffold(
          body: ResponsiveLayoutBuilder(
            desktop: (context, constraints) => const Text('DESKTOP_VIEW'),
            tablet: (context, constraints) => const Text('TABLET_VIEW'),
            mobile: (context, constraints) => const Text('MOBILE_VIEW'),
          ),
        ),
      );
    }

    testWidgets('renders desktop view when width >= 1200', (tester) async {
      tester.view.physicalSize = const Size(1440, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('DESKTOP_VIEW'), findsOneWidget);
      expect(find.text('TABLET_VIEW'), findsNothing);
      expect(find.text('MOBILE_VIEW'), findsNothing);
    });

    testWidgets('renders tablet view when 768 <= width < 1200', (tester) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('TABLET_VIEW'), findsOneWidget);
      expect(find.text('DESKTOP_VIEW'), findsNothing);
      expect(find.text('MOBILE_VIEW'), findsNothing);
    });

    testWidgets('renders mobile view when width < 768', (tester) async {
      tester.view.physicalSize = const Size(600, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('MOBILE_VIEW'), findsOneWidget);
      expect(find.text('DESKTOP_VIEW'), findsNothing);
      expect(find.text('TABLET_VIEW'), findsNothing);
    });
  });
}
