import 'dart:convert';

import 'package:http/http.dart' as http;

/// Firma inyectable de [fetchPokemon]; permite usar un fake en los tests.
typedef PokemonFetcher = Future<Map<String, dynamic>> Function(String name);

/// Obtiene los datos de un Pokémon por nombre desde la PokéAPI.
///
/// Acepta un [client] opcional para inyectar un mock en los tests.
Future<Map<String, dynamic>> fetchPokemon(
  String nombre, {
  http.Client? client,
}) async {
  client ??= http.Client();

  if (nombre.trim().isEmpty) throw Exception('Ingresa un nombre válido');

  final url = Uri.parse(
    'https://pokeapi.co/api/v2/pokemon/${nombre.toLowerCase()}',
  );

  final response = await client.get(url);

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Pokémon no encontrado');
  }
}
