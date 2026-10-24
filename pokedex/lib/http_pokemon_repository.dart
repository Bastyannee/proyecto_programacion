import 'dart:convert';

import 'package:http/http.dart' as http;

import 'pokemon_repository.dart';
import 'pokemon_summary.dart';

/// Implementación real contra `https://pokeapi.co/api/v2/pokemon`.
class HttpPokemonRepository implements PokemonRepository {
  HttpPokemonRepository({http.Client? client})
    : _client = client ?? http.Client();

  final http.Client _client;

  @override
  Future<List<PokemonSummary>> fetchPage({
    required int limit,
    required int offset,
  }) async {
    final uri = Uri.https('pokeapi.co', '/api/v2/pokemon', {
      'limit': '$limit',
      'offset': '$offset',
    });
    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw Exception('PokéAPI respondió ${response.statusCode}');
    }
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final results = body['results'] as List<dynamic>;
    return results
        .map((e) => PokemonSummary.fromListEntry(e as Map<String, dynamic>))
        .toList();
  }
}
