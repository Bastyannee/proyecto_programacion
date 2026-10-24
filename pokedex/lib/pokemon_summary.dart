import 'nickname_manager.dart';
/// Datos mínimos de un Pokémon para mostrarlo en la lista.
class PokemonSummary {
  const PokemonSummary({required this.id, required this.name});

  /// Construye el modelo desde una entrada de `GET /pokemon`
  /// (`{"name": "...", "url": ".../pokemon/1/"}`); el id es el último
  /// segmento de la URL.
  factory PokemonSummary.fromListEntry(Map<String, dynamic> json) {
    final segments = Uri.parse(json['url'] as String).pathSegments
        .where((s) => s.isNotEmpty)
        .toList();
    return PokemonSummary(
      id: int.parse(segments.last),
      name: json['name'] as String,
    );
  }

  final int id;
  final String name;

  /// Sprite en el repo público de PokéAPI; se arma con el id, sin llamadas extra.
  String get spriteUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

  /// Nombre con la primera letra en mayúscula (`bulbasaur` → `Bulbasaur`).
  String get displayName{
    //busca si tiene apodo
    final customName = NicknameManager().getDisplayName(name);
     return name.isEmpty ? customName : '${name[0].toUpperCase()}${name.substring(1)}';
  }

  /// Número de Pokédex con ceros a la izquierda (`1` → `#001`).
  String get numberLabel => '#${id.toString().padLeft(3, '0')}';
}
