// lib/game/enemies/boss1.dart

import 'package:flame/components.dart';
import 'package:ruins_legacy/game/components/enemies/enemy.dart';

// Implementasi musuh 'Boss1'
class Boss1 extends Enemy {
  Boss1({Vector2? position})
      : super(
          name: 'Guardian Golem',
          maxHp: 150,
          attack: 10,
          position: position,
        );

  @override
  Future<void> onLoad() async {
    // Ganti dengan aset sprite untuk boss
    sprite = await game.loadSprite('npc.png'); 
    size = Vector2.all(64);
    await super.onLoad();
  }
}