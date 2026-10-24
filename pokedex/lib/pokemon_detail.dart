import 'nickname_manager.dart';
/// Datos del detalle de un Pokémon (`GET /pokemon/{name}`).
class PokemonDetail {
  const PokemonDetail({
    required this.name,
    required this.weight,
    required this.height,
    this.spriteUrl,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    final sprites = json['sprites'] as Map<String, dynamic>?;
    return PokemonDetail(
      name: json['name'] as String,
      weight: json['weight'] as int,
      height: json['height'] as int,
      spriteUrl: sprites?['front_default'] as String?,
    );
  }

  final String name;
  final int weight;
  final int height;

  /// Puede ser nulo: algunos Pokémon no tienen sprite frontal.
  final String? spriteUrl;

  String get displayName {
    // verificar si tiene apodo
    final customName = NicknameManager().getDisplayName(name);
    return customName.toUpperCase(); 
  }

  String get measuresLabel => 'Peso: $weight hg | Altura: $height dm';
}
