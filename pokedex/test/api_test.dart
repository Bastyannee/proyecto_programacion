import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:pokedex/pokemon_api.dart';

@GenerateMocks([http.Client])
import 'api_test.mocks.dart';

void main() {
  group('fetchPokemon', () {
    test('Devuelve un Map si la llamada HTTP es exitosa (200)', () async {
      // 1. Arrange (Preparar)
      final client = MockClient();
      final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/pikachu');

      // Simulamos (Mockeamos) que cuando el cliente intente ir a esa URL, devolverá este JSON inventado
      when(client.get(url)).thenAnswer(
        (_) async => http.Response('{"name": "pikachu", "weight": 60}', 200),
      );

      // 2. Act (Actuar) - ¡Le pasamos el cliente falso a nuestra función!
      final resultado = await fetchPokemon('pikachu', client: client);

      // 3. Assert (Comprobar)
      expect(resultado['name'], 'pikachu');
      expect(resultado['weight'], 60);
    });
  });
}
