import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart'; 
import 'package:pokedex/pokemon_equipo_ventana.dart';
import 'package:pokedex/pokemon_team_state.dart'; 

void main() {
  setUp(() {
    // Limpiamos el estado antes de correr la prueba
    PokemonTeamState().resetForTesting();
  });

  testWidgets('Debe mostrar la ventana de Mi Equipo vacía', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: PokemonTeamState(),
        child: const MaterialApp(
          home: PokemonTeamScreen(),
        ),
      ),
    );

    // Verificamos el título del AppBar
    expect(find.text('Mi Equipo'), findsOneWidget);
    
    // ARREGLO: Usamos textContaining para que detecte la frase aunque tenga saltos de línea u otras instrucciones después.
    expect(find.textContaining('Tu equipo está vacío'), findsOneWidget);
  });
}