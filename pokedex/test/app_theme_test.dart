import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app_theme.dart';

void main() {
  group('AppTheme - Paletas de Colores', () {
    test('lightTheme debe tener los colores correctos para el modo claro', () {
      final theme = AppTheme.lightTheme;
      
      expect(theme.brightness, Brightness.light);
      expect(theme.primaryColor, Colors.redAccent);
      expect(theme.scaffoldBackgroundColor, Colors.grey[100]);
      expect(theme.appBarTheme.backgroundColor, Colors.redAccent);
      expect(theme.useMaterial3, true);
    });

    test('darkTheme debe tener los colores correctos para el modo oscuro', () {
      final theme = AppTheme.darkTheme;
      
      expect(theme.brightness, Brightness.dark);
      expect(theme.primaryColor, Colors.red[800]);
      expect(theme.scaffoldBackgroundColor, const Color(0xFF121212));
      expect(theme.appBarTheme.backgroundColor, Colors.red[900]);
      expect(theme.useMaterial3, true);
    });
  });
}