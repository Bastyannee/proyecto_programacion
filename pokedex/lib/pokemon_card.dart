import 'package:flutter/material.dart';

import 'pokemon_sprite.dart';
import 'pokemon_summary.dart';

/// Tarjeta presentacional de un Pokémon en la lista.
class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key, required this.pokemon, this.onTap});

  final PokemonSummary pokemon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: PokemonSprite(url: pokemon.spriteUrl, size: 56),
      title: Text(pokemon.displayName),
      trailing: Text(pokemon.numberLabel),
    );
  }
}
