import 'package:flutter/material.dart';

/// Sprite de un Pokémon con ícono de respaldo si no hay URL o falla la carga.
class PokemonSprite extends StatelessWidget {
  const PokemonSprite({super.key, required this.url, required this.size});

  final String? url;
  final double size;

  @override
  Widget build(BuildContext context) {
    final fallback = SizedBox(
      width: size,
      height: size,
      child: Icon(Icons.catching_pokemon, size: size / 2),
    );
    final spriteUrl = url;
    if (spriteUrl == null) return fallback;
    return Image.network(
      spriteUrl,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => fallback,
    );
  }
}
