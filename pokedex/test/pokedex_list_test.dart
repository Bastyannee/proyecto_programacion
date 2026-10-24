import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/pokedex_screen.dart';
import 'package:pokedex/pokemon_api.dart';
import 'package:pokedex/pokemon_repository.dart';
import 'package:pokedex/pokemon_summary.dart';

import 'pokemon_fixtures.dart';

/// Repositorio falso: respeta limit/offset y registra la última llamada.
class FakePokemonRepository implements PokemonRepository {
  FakePokemonRepository(this._all);

  final List<PokemonSummary> _all;
  int? lastLimit;
  int? lastOffset;

  @override
  Future<List<PokemonSummary>> fetchPage({
    required int limit,
    required int offset,
  }) async {
    lastLimit = limit;
    lastOffset = offset;
    return _all.skip(offset).take(limit).toList();
  }
}

List<PokemonSummary> _generate(int count) => List.generate(
  count,
  (i) => PokemonSummary(id: i + 1, name: 'poke${i + 1}'),
);

Future<void> _pumpScreen(
  WidgetTester tester,
  FakePokemonRepository repository, {
  PokemonFetcher? fetchDetail,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: PokedexScreen(
        repository: repository,
        fetchDetail: fetchDetail ?? fetchPokemon,
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  group('PokemonSummary', () {
    test('fromListEntry extrae el id desde la URL de la PokéAPI', () {
      // Arrange
      final json = {
        'name': 'bulbasaur',
        'url': 'https://pokeapi.co/api/v2/pokemon/1/',
      };

      // Act
      final pokemon = PokemonSummary.fromListEntry(json);

      // Assert
      expect(pokemon.id, 1);
      expect(pokemon.displayName, 'Bulbasaur');
      expect(pokemon.numberLabel, '#001');
    });

    test('spriteUrl se arma con el id, sin llamadas extra a la API', () {
      // Arrange
      const pokemon = PokemonSummary(id: 25, name: 'pikachu');

      // Act
      final url = pokemon.spriteUrl;

      // Assert
      expect(url, endsWith('/sprites/pokemon/25.png'));
    });
  });

  group('PokedexScreen', () {
    // Criterio 1: la página principal muestra una lista de pokemon.
    testWidgets('muestra una lista de pokemon', (tester) async {
      // Arrange
      final repository = FakePokemonRepository([
        const PokemonSummary(id: 1, name: 'bulbasaur'),
        const PokemonSummary(id: 4, name: 'charmander'),
      ]);

      // Act
      await _pumpScreen(tester, repository);

      // Assert
      expect(find.byKey(const Key('pokemonList')), findsOneWidget);
      expect(find.text('Bulbasaur'), findsOneWidget);
      expect(find.text('Charmander'), findsOneWidget);
    });

    // Criterio 2: ordenados por número de Pokédex.
    testWidgets('ordena los pokemon por su id de Pokédex', (tester) async {
      // Arrange: el repositorio devuelve los datos desordenados a propósito.
      final repository = FakePokemonRepository([
        const PokemonSummary(id: 25, name: 'pikachu'),
        const PokemonSummary(id: 1, name: 'bulbasaur'),
        const PokemonSummary(id: 4, name: 'charmander'),
      ]);

      // Act
      await _pumpScreen(tester, repository);

      // Assert: posición vertical creciente = orden creciente por id.
      final bulbasaurY = tester.getTopLeft(find.text('Bulbasaur')).dy;
      final charmanderY = tester.getTopLeft(find.text('Charmander')).dy;
      final pikachuY = tester.getTopLeft(find.text('Pikachu')).dy;
      expect(bulbasaurY, lessThan(charmanderY));
      expect(charmanderY, lessThan(pikachuY));
    });

    // Criterio 3: el usuario elige cuántos pokemon se muestran por página.
    testWidgets('permite elegir cuántos pokemon se muestran por página', (
      tester,
    ) async {
      // Arrange
      final repository = FakePokemonRepository(_generate(30));
      await _pumpScreen(tester, repository);
      int itemCount() => tester
          .widget<ListView>(find.byKey(const Key('pokemonList')))
          .semanticChildCount!;
      expect(itemCount(), 10); // valor por defecto

      // Act
      await tester.tap(find.byKey(const Key('pageSizeDropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('20').last);
      await tester.pumpAndSettle();

      // Assert
      expect(repository.lastLimit, 20);
      expect(itemCount(), 20);
    });

    testWidgets('el botón siguiente carga la página 2', (tester) async {
      // Arrange
      final repository = FakePokemonRepository(_generate(30));
      await _pumpScreen(tester, repository);

      // Act
      await tester.tap(find.byKey(const Key('nextPageButton')));
      await tester.pumpAndSettle();

      // Assert
      expect(repository.lastOffset, 10);
      expect(find.text('#011'), findsOneWidget);
      expect(find.text('#001'), findsNothing);
    });

    testWidgets('cada tarjeta muestra el sprite del pokemon', (tester) async {
      // Arrange
      const pikachu = PokemonSummary(id: 25, name: 'pikachu');
      final repository = FakePokemonRepository([pikachu]);

      // Act
      await _pumpScreen(tester, repository);

      // Assert
      final image = tester.widget<Image>(find.byType(Image));
      expect((image.image as NetworkImage).url, pikachu.spriteUrl);
    });

    testWidgets('al tocar una tarjeta se abre el detalle', (tester) async {
      // Arrange
      String? requested;
      final repository = FakePokemonRepository([
        const PokemonSummary(id: 1, name: 'bulbasaur'),
      ]);
      await _pumpScreen(
        tester,
        repository,
        fetchDetail: (name) async {
          requested = name;
          return pokemonJson(name);
        },
      );

      // Act
      await tester.tap(find.text('Bulbasaur'));
      await tester.pumpAndSettle();

      // Assert
      expect(requested, 'bulbasaur');
      expect(find.text('BULBASAUR'), findsOneWidget);
    });

    testWidgets('buscar por nombre abre el detalle', (tester) async {
      // Arrange
      String? requested;
      final repository = FakePokemonRepository(_generate(3));
      await _pumpScreen(
        tester,
        repository,
        fetchDetail: (name) async {
          requested = name;
          return pokemonJson(name);
        },
      );

      // Act
      await tester.enterText(
        find.byKey(const Key('searchField')),
        '  Pikachu ',
      );
      await tester.tap(find.byKey(const Key('searchButton')));
      await tester.pumpAndSettle();

      // Assert
      expect(requested, 'Pikachu');
      expect(find.text('PIKACHU'), findsOneWidget);
    });

    testWidgets('buscar con el campo vacío avisa y no navega', (tester) async {
      // Arrange
      var calls = 0;
      final repository = FakePokemonRepository(_generate(3));
      await _pumpScreen(
        tester,
        repository,
        fetchDetail: (name) async {
          calls++;
          return pokemonJson(name);
        },
      );

      // Act
      await tester.tap(find.byKey(const Key('searchButton')));
      await tester.pump();

      // Assert
      expect(find.text('Ingresa un nombre válido'), findsOneWidget);
      expect(calls, 0);
    });
  });
}
