import 'package:flutter_test/flutter_test.dart';
import '../lib/nickname_manager.dart';

void main() {
  group('NicknameManager', () {
    test('Devuelve el nombre original si no hay apodo', () {
      final manager = NicknameManager();
      expect(manager.getDisplayName('bulbasaur'), 'bulbasaur');
    });

    test('Guarda y devuelve el apodo correctamente', () {
      final manager = NicknameManager();
      manager.setNickname('charmander', 'Fueguito');
      expect(manager.getDisplayName('charmander'), 'Fueguito');
    });
  });
}