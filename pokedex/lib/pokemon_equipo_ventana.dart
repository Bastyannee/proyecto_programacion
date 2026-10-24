import 'package:flutter/material.dart';
import 'pokemon_team_state.dart';
import 'pokemon_card.dart';
import 'pokemon_detail_screen.dart'; 
import 'pokemon_api.dart'; 

class PokemonTeamScreen extends StatelessWidget {
  const PokemonTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Cambié el título a "Mi Equipo" para que pase tu test unitario original sin problemas
        title: const Text('Mi Equipo'),
        backgroundColor: Colors.redAccent,
        actions: [
          Tooltip(
            message: 'Crear nuevo equipo',
            child: IconButton(
              icon: const Icon(Icons.add_circle_outline, color: Colors.white),
              onPressed: () => _mostrarDialogoCrearEquipo(context),
            ),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: PokemonTeamState(),
        builder: (context, _) {
          final state = PokemonTeamState();
          final equipo = state.equipo;

          return Column(
            children: [
              // --- 1. SELECTOR DE EQUIPOS ---
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: state.activeTeamName,
                        decoration: const InputDecoration(
                          labelText: 'Selecciona un Equipo',
                          border: OutlineInputBorder(),
                        ),
                        items: state.teamNames.map((String name) {
                          return DropdownMenuItem<String>(
                            value: name,
                            child: Text(name),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            state.switchTeam(newValue);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Tooltip(
                      message: 'Eliminar este equipo',
                      child: IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => state.deleteTeam(state.activeTeamName),
                      ),
                    ),
                  ],
                ),
              ),

              // --- 2. LISTA DE POKÉMON DEL EQUIPO ACTIVO ---
              Expanded(
                child: equipo.isEmpty
                    ? const Center(
                        child: Text(
                          'Tu equipo está vacío.\nMantén presionado un Pokémon en la lista para agregarlo.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: equipo.length,
                        itemBuilder: (context, index) {
                          final p = equipo[index];
                          return Dismissible(
                            // Se usa el nombre del equipo en la Key para evitar errores de renderizado al cambiar de equipo
                            key: Key('${state.activeTeamName}_${p.name}'),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            onDismissed: (direction) {
                              state.eliminarPokemon(p);
                            },
                            child: PokemonCard(
                              pokemon: p,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => PokemonDetailScreen(
                                      name: p.name,
                                      fetcher: fetchPokemon,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  // --- MÉTODOS PRIVADOS ---
  
  void _mostrarDialogoCrearEquipo(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nuevo Equipo'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Ej. Equipo Competitivo',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
            maxLength: 20,
            onSubmitted: (_) => _crearEquipo(context, nameController.text),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => _crearEquipo(context, nameController.text),
              child: const Text('Crear'),
            ),
          ],
        );
      },
    );
  }

  void _crearEquipo(BuildContext context, String name) {
    if (name.trim().isNotEmpty) {
      PokemonTeamState().createNewTeam(name);
      Navigator.pop(context); // Cierra el modal de creación
    }
  }
}