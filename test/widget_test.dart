import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oms_new/core/di/injection.dart';
import 'package:oms_new/main.dart';

void main() {
  setUp(() async {
    await getIt.reset();
    await configureDependencies();
  });

  tearDown(() async {
    await getIt.reset();
  });

  testWidgets('OmsClinicPortalApp renders login page by default', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const OmsClinicPortalApp());
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('username_field')), findsOneWidget);
    expect(find.byKey(const Key('password_field')), findsOneWidget);
    expect(find.byKey(const Key('login_button')), findsOneWidget);
  });
}
