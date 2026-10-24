import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'http_pokemon_repository.dart';
import 'pokedex_screen.dart';
import 'theme_state.dart';

void main() {
  runApp(const MainApp());
}

/// Raíz de la aplicación. Escucha a [ThemeState] para aplicar el tema
/// claro u oscuro de forma reactiva en todas las pantallas.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ThemeState(),
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pokédex - Grupo 9',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeState().themeMode,
          home: PokedexScreen(repository: HttpPokemonRepository()),
        );
      },
    );
  }
}
