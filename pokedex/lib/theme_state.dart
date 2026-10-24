import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Gestor de estado del tema de la aplicación (claro u oscuro).
/// Es un Singleton: todas las pantallas comparten la misma instancia, por lo
/// que `MaterialApp` y el botón de alternancia reaccionan al mismo estado.
class ThemeState extends ChangeNotifier {
  static final ThemeState _instance = ThemeState._internal();
  factory ThemeState() => _instance;
  ThemeState._internal();

  ThemeMode _themeMode = ThemeMode.light;

  /// Modo de tema actual. Por defecto es [ThemeMode.light].
  ThemeMode get themeMode => _themeMode;

  /// Indica si el modo oscuro está activo.
  bool get isDark => _themeMode == ThemeMode.dark;

  /// Alterna entre modo claro y oscuro y notifica a los listeners.
  void toggleTheme() {
    _themeMode = isDark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  /// Restablece el estado inicial. Solo para pruebas, por el Singleton.
  @visibleForTesting
  void resetForTesting() {
    _themeMode = ThemeMode.light;
  }
}
