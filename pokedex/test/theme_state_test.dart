import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/theme_state.dart';

void main() {
  late ThemeState state;

  // El Singleton conserva su estado entre tests, por eso se reinicia antes de cada uno.
  setUp(() {
    state = ThemeState();
    state.resetForTesting();
  });

  group('ThemeState', () {
    test('el modo inicial es claro', () {
      expect(state.themeMode, ThemeMode.light);
    });

    test('toggleTheme alterna de claro a oscuro', () {
      state.toggleTheme();
      expect(state.themeMode, ThemeMode.dark);
    });

    test('toggleTheme alterna de oscuro a claro', () {
      state.toggleTheme();
      state.toggleTheme();
      expect(state.themeMode, ThemeMode.light);
    });

    test('toggleTheme notifica a los listeners', () {
      var notificaciones = 0;
      state.addListener(() => notificaciones++);

      state.toggleTheme();

      expect(notificaciones, 1);
    });

    test('es un Singleton: todas las instancias comparten el estado', () {
      ThemeState().toggleTheme();
      expect(ThemeState().themeMode, ThemeMode.dark);
    });

    test('isDark refleja el modo actual', () {
      expect(state.isDark, false);
      state.toggleTheme();
      expect(state.isDark, true);
    });
  });
}
