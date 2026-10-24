import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/theme_state.dart';
import 'package:pokedex/theme_toggle_button.dart';

void main() {
  // El Singleton conserva su estado entre tests, por eso se reinicia antes de cada uno.
  setUp(() {
    ThemeState().resetForTesting();
  });

  /// Monta el botón dentro de un AppBar, como se usa en la aplicación.
  Future<void> montarBoton(WidgetTester tester) {
    return tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(actions: const [ThemeToggleButton()]),
        ),
      ),
    );
  }

  /// Pruebas del botón: ícono según el modo y alternancia al presionarlo.
  group('ThemeToggleButton', () {
    testWidgets('muestra el ícono de luna en modo claro', (tester) async {
      await montarBoton(tester);

      expect(find.byIcon(Icons.dark_mode), findsOneWidget);
      expect(find.byIcon(Icons.light_mode), findsNothing);
    });

    testWidgets('al presionarlo activa el modo oscuro y muestra el sol',
        (tester) async {
      await montarBoton(tester);

      await tester.tap(find.byType(IconButton));
      await tester.pump();

      expect(ThemeState().isDark, true);
      expect(find.byIcon(Icons.light_mode), findsOneWidget);
    });

    testWidgets('al presionarlo dos veces vuelve al modo claro',
        (tester) async {
      await montarBoton(tester);

      await tester.tap(find.byType(IconButton));
      await tester.pump();
      await tester.tap(find.byType(IconButton));
      await tester.pump();

      expect(ThemeState().isDark, false);
      expect(find.byIcon(Icons.dark_mode), findsOneWidget);
    });
  });
}
