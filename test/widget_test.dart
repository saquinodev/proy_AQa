import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proy_aqa/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Esperar a que se complete la navegación a HomeScreen
    await tester.pump();

    // Verificar que el contador comienza en 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tocar el ícono de incremento y esperar a que se complete la animación
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verificar que el contador se ha incrementado a 1.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}