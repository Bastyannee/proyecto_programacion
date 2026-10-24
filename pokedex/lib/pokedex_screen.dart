import 'package:flutter/material.dart';

import 'page_size_selector.dart';
import 'pokemon_api.dart';
import 'pokemon_card.dart';
import 'pokemon_detail_screen.dart';
import 'pokemon_repository.dart';
import 'pokemon_search_bar.dart';
import 'pokemon_summary.dart';
import 'package:pokedex/pokemon_equipo_ventana.dart';
import 'pokemon_team_state.dart';
import 'pokemon_filter.dart';
import 'pokemon_filter_window.dart';
import 'theme_toggle_button.dart';

/// Pantalla principal: búsqueda por nombre y lista paginada ordenada por
/// número de Pokédex. Solo orquesta; la presentación vive en widgets propios.
class PokedexScreen extends StatefulWidget {
  const PokedexScreen({
    super.key,
    required this.repository,
    this.fetchDetail = fetchPokemon,
  });

  final PokemonRepository repository;
  final PokemonFetcher fetchDetail;

  @override
  State<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  static const int _defaultPageSize = 10;

  int _pageSize = _defaultPageSize;
  int _page = 0;
  late Future<List<PokemonSummary>> _future;
  PokemonFilter _activeFilter = const PokemonFilter();

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<List<PokemonSummary>> _load() async {
    final items = await widget.repository.fetchPage(
      limit: _pageSize,
      offset: _page * _pageSize,
    );
    return [...items]..sort((a, b) => a.id.compareTo(b.id));
  }

  void _reload({int? pageSize, int? page}) {
    setState(() {
      _pageSize = pageSize ?? _pageSize;
      _page = page ?? _page;
      _future = _load();
    });
  }
  
  void _openFilterWindow() async {
  final result = await showModalBottomSheet<PokemonFilter>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => PokemonFilterWindow(currentFilter: _activeFilter),
  );

  if (result != null) {
    setState(() {
      _activeFilter = result;
    });
  }
}

  void _openDetail(String name) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) =>
            PokemonDetailScreen(name: name, fetcher: widget.fetchDetail),
      ),
    ).then((_){
      setState(() {});
    });
  }

  void _search(String name) {
    if (name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Ingresa un nombre válido')));
      return;
    }
    _openDetail(name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex - Grupo 9'),
        // --- AQUÍ SE AGREGÓ EL BOTÓN PARA VER EL EQUIPO ---
        actions: [
          const ThemeToggleButton(),
          // Adición de botón de filtros
          IconButton(
            icon: const Icon(Icons.filter_alt),
            tooltip: 'Filtrar Pokémon',
            onPressed: _openFilterWindow,
  ),
          /// Botón superior derecho que navega hacia la pantalla "Mi Equipo".
          /// Utiliza Navigator.push para apilar la nueva pantalla sobre la principal.
          IconButton(
            icon: const Icon(Icons.catching_pokemon),
            tooltip: 'Ver mi equipo',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PokemonTeamScreen(),
                ),
              );
            },
          ),
        ],
        // --------------------------------------------------
      ),
      body: Column(
        children: [
          PokemonSearchBar(onSearch: _search),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: PageSizeSelector(
                    value: _pageSize,
                    onChanged: (size) => _reload(pageSize: size, page: 0),
                  ),
                ),
                IconButton(
                  key: const Key('previousPageButton'),
                  icon: const Icon(Icons.chevron_left),
                  onPressed: _page > 0 ? () => _reload(page: _page - 1) : null,
                ),
                IconButton(
                  key: const Key('nextPageButton'),
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () => _reload(page: _page + 1),
                ),
              ],
            ),
          ),
          Expanded(child: _buildList()),
        ],
      ),
    );
  }

  Widget _buildList() {
    return FutureBuilder<List<PokemonSummary>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar los Pokémon'));
        }
        final pokemon = snapshot.data!;
        return ListView.builder(
          key: const Key('pokemonList'),
          itemCount: pokemon.length,
          itemBuilder: (context, index) {
            final p = pokemon[index];
            // Envolvemos la carta en un GestureDetector para detectar el presionado largo
            return GestureDetector(
              onLongPress: () {
                try {
                  PokemonTeamState().agregarPokemon(p);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('¡${p.name} se unió a tu equipo!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  // Si hay más de 6, mostramos el error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString().replaceAll('Exception: ', '')),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: PokemonCard(pokemon: p, onTap: () => _openDetail(p.name)),
            );
          },
        );
      },
    );
  }
}