/// JSON mínimo con la forma de `GET /pokemon/{name}` de la PokéAPI.
Map<String, dynamic> pokemonJson(String name, {String? sprite}) => {
  'name': name,
  'weight': 60,
  'height': 4,
  'sprites': {'front_default': sprite ?? 'https://example.com/$name.png'},
};
