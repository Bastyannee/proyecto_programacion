import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/pokemon_detail.dart';
import 'package:pokedex/pokemon_detail_screen.dart';

import 'pokemon_fixtures.dart';

void main() {
  group('PokemonDetail', () {
    test('fromJson lee nombre, peso, altura y sprite', () {
      // Arrange
      final json = pokemonJson('pikachu', sprite: 'https://x/pikachu.png');

      // Act
      final detail = PokemonDetail.fromJson(json);

      // Assert
      expect(detail.displayName, 'PIKACHU');
      expect(detail.measuresLabel, 'Peso: 60 hg | Altura: 4 dm');
      expect(detail.spriteUrl, 'https://x/pikachu.png');
    });

    test('fromJson tolera un sprite nulo', () {
      // Arrange
      final json = pokemonJson('missingno')
        ..['sprites'] = {'front_default': null};

      // Act
      final detail = PokemonDetail.fromJson(json);

      // Assert
      expect(detail.spriteUrl, isNull);
    });
  });

  group('PokemonDetailScreen', () {
    testWidgets('muestra sprite, nombre, peso y altura', (tester) async {
      // Arrange
      Future<Map<String, dynamic>> fetcher(String name) async =>
          pokemonJson(name);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: PokemonDetailScreen(name: 'pikachu', fetcher: fetcher),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('PIKACHU'), findsOneWidget);
      expect(find.text('Peso: 60 hg | Altura: 4 dm'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('muestra un ícono si el pokemon no tiene sprite', (
      tester,
    ) async {
      // Arrange
      Future<Map<String, dynamic>> fetcher(String name) async =>
          pokemonJson(name)..['sprites'] = {'front_default': null};

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: PokemonDetailScreen(name: 'missingno', fetcher: fetcher),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(Image), findsNothing);
      expect(find.byIcon(Icons.catching_pokemon), findsOneWidget);
    });

    testWidgets('muestra el error si el pokemon no existe', (tester) async {
      // Arrange
      Future<Map<String, dynamic>> fetcher(String name) async =>
          throw Exception('Pokémon no encontrado');

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: PokemonDetailScreen(name: 'xyz', fetcher: fetcher),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('❌ Pokémon no encontrado'), findsOneWidget);
    });
  });
}
