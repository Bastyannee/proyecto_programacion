import 'package:flutter/material.dart';
import 'nickname_manager.dart';
import 'pokemon_sprite.dart';
import 'pokemon_api.dart';
import 'pokemon_detail.dart';

/// Vista de detalle (la del `main.dart` original), ahora reutilizable.
class PokemonDetailScreen extends StatefulWidget {
  const PokemonDetailScreen({
    super.key,
    required this.name,
    this.fetcher = fetchPokemon,
  });

  final String name;
  final PokemonFetcher fetcher;

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  // Se pide una sola vez (el original volvía a pedir en cada rebuild).
  late final Future<PokemonDetail> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.fetcher(widget.name).then(PokemonDetail.fromJson);
  }

  // Método para mostrar el popup de cambio de nombre
  void _mostrarDialogoApodo(BuildContext context, String originalName) {
    final TextEditingController controller = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Asignar Apodo'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Ej. Destructor'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text('Cancelar')
            ),
            ElevatedButton(
              onPressed: () {
                // Guarda el apodo y refresca la pantalla
                NicknameManager().setNickname(originalName, controller.text);
                setState(() {}); 
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle')),
      body: FutureBuilder<PokemonDetail>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            final message = snapshot.error.toString().replaceFirst(
              'Exception: ',
              '',
            );
            return Center(
              child: Text('❌ $message', style: const TextStyle(fontSize: 16)),
            );
          }
          final detail = snapshot.data!;
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PokemonSprite(url: detail.spriteUrl, size: 200),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Text(
                  detail.displayName,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  color: Colors.grey[700],
                  onPressed: () => _mostrarDialogoApodo(context, detail.name),
                    ),
                  ],
                ),
                Text(
                  detail.measuresLabel,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
