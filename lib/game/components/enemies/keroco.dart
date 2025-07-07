// lib/game/enemies/keroco.dart

import 'package:flame/components.dart';
import 'package:ruins_legacy/game/components/enemies/enemy.dart';

// Implementasi musuh 'Keroco' (level rendah)
class Keroco extends Enemy {
  Keroco({Vector2? position})
      : super(
          name: 'Keroco',
          maxHp: 30,
          attack: 3,
          position: position,
        );

  @override
  Future<void> onLoad() async {
    animation = await game.loadSpriteAnimation(
      'enemy_sprite.png', // Ganti dengan nama file sprite musuh Anda
      SpriteAnimationData.sequenced(
        amount: 4, // Jumlah frame
        stepTime: 0.2,
        textureSize: Vector2(32, 32), // Ukuran satu frame
      ),
    );
    await super.onLoad();
  }
}