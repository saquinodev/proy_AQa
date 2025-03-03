import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proy_aqa/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    await tester.pump();

    // 🔍 DEBUG: Listar todos los textos que se cargan
    final allTextWidgets = find.byType(Text);
    for (var text in allTextWidgets.evaluate()) {
      print((text.widget as Text).data);
    }

    // Verificar que el contador comienza en 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
