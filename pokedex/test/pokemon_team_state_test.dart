import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/pokemon_team_state.dart';
import 'package:pokedex/pokemon_summary.dart';

// Mock simple para simular Pokémones en las pruebas
class MockPokemon implements PokemonSummary {
  @override
  final int id;
  @override
  final String name;
  
  MockPokemon(this.id, this.name);
  
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late PokemonTeamState estado;

  // Setup: Se ejecuta ANTES de cada prueba para garantizar un entorno limpio
  setUp(() {
    estado = PokemonTeamState();
    estado.resetForTesting();
  });

  group('PokemonTeamState - Gestión Multi-Equipo', () {
    test('El estado inicial debe contener "Team 1" vacío', () {
      expect(estado.teamNames.length, 1);
      expect(estado.activeTeamName, 'Team 1');
      expect(estado.equipo.isEmpty, true);
    });

    test('Crear un nuevo equipo lo agrega a la lista y lo hace activo', () {
      estado.createNewTeam('Equipo Competitivo');
      
      expect(estado.teamNames.length, 2);
      expect(estado.activeTeamName, 'Equipo Competitivo');
    });

    test('Eliminar el único equipo regenera el "Team 1" por defecto', () {
      estado.deleteTeam('Team 1');
      
      expect(estado.teamNames.length, 1);
      expect(estado.activeTeamName, 'Team 1');
    });
  });

  group('PokemonTeamState - Lógica de Equipo (Límites y Duplicados)', () {
    test('Debe agregar un Pokémon correctamente', () {
      final pika = MockPokemon(25, 'Pikachu');
      estado.agregarPokemon(pika);
      
      expect(estado.equipo.length, 1);
      expect(estado.equipo.first.name, 'Pikachu');
    });

    test('No debe permitir agregar duplicados', () {
      final bulba = MockPokemon(1, 'Bulbasaur');
      estado.agregarPokemon(bulba);
      
      expect(() => estado.agregarPokemon(bulba), throwsException);
    });

    test('No debe permitir más de 6 Pokémon', () {
      // Llenamos los 6 cupos
      for (int i = 1; i <= 6; i++) {
        estado.agregarPokemon(MockPokemon(i, 'Pokemon $i'));
      }
      
      // El 7mo debe fallar
      final extra = MockPokemon(7, 'Mewtwo');
      expect(() => estado.agregarPokemon(extra), throwsException);
    });
  });
}