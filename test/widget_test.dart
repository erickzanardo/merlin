import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:merlin_editor/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
