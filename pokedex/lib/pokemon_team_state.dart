import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Agregado para usar @visibleForTesting
import 'pokemon_summary.dart';

class PokemonTeamState extends ChangeNotifier {
  // Patrón Singleton mantenido
  static final PokemonTeamState _instance = PokemonTeamState._internal();
  factory PokemonTeamState() => _instance;
  PokemonTeamState._internal();

  // Almacenamiento múltiple y rastreador del equipo activo
  final Map<String, List<PokemonSummary>> _teams = {
    'Team 1': [],
  };
  String _activeTeamName = 'Team 1';

  // Getters actualizados
  String get activeTeamName => _activeTeamName;
  List<String> get teamNames => _teams.keys.toList();
  // El getter 'equipo' ahora devuelve solo los Pokémon del equipo activo
  List<PokemonSummary> get equipo => List.unmodifiable(_teams[_activeTeamName] ?? []);

  // --- GESTIÓN DE EQUIPOS ---

  void createNewTeam(String teamName) {
    if (!_teams.containsKey(teamName) && teamName.trim().isNotEmpty) {
      _teams[teamName] = [];
      _activeTeamName = teamName;
      notifyListeners();
    }
  }

  void switchTeam(String teamName) {
    if (_teams.containsKey(teamName)) {
      _activeTeamName = teamName;
      notifyListeners();
    }
  }

  void deleteTeam(String teamName) {
    if (_teams.containsKey(teamName)) {
      _teams.remove(teamName);
      
      // Prevención de errores si se eliminan todos los equipos
      if (_teams.isEmpty) {
        _teams['Team 1'] = [];
        _activeTeamName = 'Team 1';
      } else if (_activeTeamName == teamName) {
        _activeTeamName = _teams.keys.first;
      }
      notifyListeners();
    }
  }

  // --- GESTIÓN DE POKÉMON (Adaptada) ---

  void agregarPokemon(PokemonSummary pokemon) {
    final currentTeam = _teams[_activeTeamName]!;

    // Tus reglas de negocio originales intactas:
    if (currentTeam.length >= 6) {
      throw Exception('¡Tu equipo ya está lleno! (Máximo 6)');
    }
    if (currentTeam.any((p) => p.id == pokemon.id)) {
      throw Exception('${pokemon.name} ya está en tu equipo.');
    }
    
    currentTeam.add(pokemon);
    notifyListeners(); 
  }

  void eliminarPokemon(PokemonSummary pokemon) {
    _teams[_activeTeamName]?.removeWhere((p) => p.id == pokemon.id);
    notifyListeners();
  }

  // --- MÉTODOS PARA TESTING ---
  
  @visibleForTesting
  void resetForTesting() {
    _teams.clear();
    _teams['Team 1'] = [];
    _activeTeamName = 'Team 1';
  }
}