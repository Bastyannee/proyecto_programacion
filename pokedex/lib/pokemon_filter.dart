class PokemonFilter {
  final Set<String> types;
  final Set<int> generations;
  final Set<String> regions;

  const PokemonFilter({
    this.types = const {},
    this.generations = const {},
    this.regions = const {},
  });
}