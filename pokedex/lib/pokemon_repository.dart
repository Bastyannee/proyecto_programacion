import 'pokemon_summary.dart';

/// Contrato para obtener una página de pokemon; desacopla la UI de la red.
abstract class PokemonRepository {
  Future<List<PokemonSummary>> fetchPage({
    required int limit,
    required int offset,
  });
}
