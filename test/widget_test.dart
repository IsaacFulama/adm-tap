import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:administration_tap/main.dart';

void main() {
  testWidgets('dashboard shows demo data disclaimer', (tester) async {
    await tester.view.setPhysicalSize(const Size(1200, 900));
    await tester.view.setDevicePixelRatio(1);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AdministrationTapApp());

    expect(find.text('Bonjour, administrateur'), findsOneWidget);
    expect(find.textContaining('DONNÉES DE DÉMONSTRATION'), findsOneWidget);
    expect(find.text('Valeurs fictives en attendant la connexion au backend.'), findsOneWidget);
  });

  testWidgets('navigation opens the finance placeholder', (tester) async {
    await tester.view.setPhysicalSize(const Size(1200, 900));
    await tester.view.setDevicePixelRatio(1);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AdministrationTapApp());
    await tester.tap(find.text('Finances').first);
    await tester.pumpAndSettle();

    expect(find.text('Les recettes et dépenses seront chargées depuis la base de données.'), findsOneWidget);
  });
}
