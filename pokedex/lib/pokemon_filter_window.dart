import 'package:flutter/material.dart';
import 'pokemon_filter.dart';

class PokemonFilterWindow extends StatefulWidget {
  final PokemonFilter currentFilter;

  const PokemonFilterWindow({super.key, required this.currentFilter});

  @override
  State<PokemonFilterWindow> createState() => _PokemonFilterWindowState();
}

class _PokemonFilterWindowState extends State<PokemonFilterWindow> {
  late Set<String> _selectedTypes;
  late Set<int> _selectedGenerations;
  late Set<String> _selectedRegions;

  final List<String> _types = ['Fuego', 'Agua', 'Planta', 'Eléctrico', 'Psíquico', 'Dragón'];
  final List<int> _generations = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  final List<String> _regions = ['Kanto', 'Johto', 'Hoenn', 'Sinnoh', 'Unova', 'Kalos', 'Alola', 'Galar', 'Paldea'];

  @override
  void initState() {
    super.initState();
    _selectedTypes = Set.from(widget.currentFilter.types);
    _selectedGenerations = Set.from(widget.currentFilter.generations);
    _selectedRegions = Set.from(widget.currentFilter.regions);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filtros',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView(
                children: [
                  const Text('Tipos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  _buildChipGroup(_types, _selectedTypes),
                  const SizedBox(height: 16),

                  const Text('Generaciones', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  _buildChipGroup(_generations, _selectedGenerations, isGen: true),
                  const SizedBox(height: 16),

                  const Text('Regiones', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  _buildChipGroup(_regions, _selectedRegions),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final newFilter = PokemonFilter(
                    types: _selectedTypes,
                    generations: _selectedGenerations,
                    regions: _selectedRegions,
                  );
                  Navigator.pop(context, newFilter);
                },
                child: const Text('Aplicar Filtros'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChipGroup<T>(List<T> items, Set<T> selectedSet, {bool isGen = false}) {
    return Wrap(
      spacing: 8.0,
      children: items.map((item) {
        final isSelected = selectedSet.contains(item);
        return FilterChip(
          label: Text(isGen ? 'Gen $item' : '$item'),
          selected: isSelected,
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                selectedSet.add(item);
              } else {
                selectedSet.remove(item);
              }
            });
          },
        );
      }).toList(),
    );
  }
}