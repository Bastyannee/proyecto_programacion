import 'package:flutter/material.dart';
import 'theme_state.dart';

/// Botón para la barra superior que alterna entre modo claro y oscuro.
///
/// Escucha a [ThemeState] y se redibuja al cambiar el tema: muestra una luna
/// en modo claro (para activar el oscuro) y un sol en modo oscuro.
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final state = ThemeState();
    return ListenableBuilder(
      listenable: state,
      builder: (context, _) {
        return IconButton(
          icon: Icon(state.isDark ? Icons.light_mode : Icons.dark_mode),
          tooltip: state.isDark ? 'Modo claro' : 'Modo oscuro',
          onPressed: state.toggleTheme,
        );
      },
    );
  }
}
