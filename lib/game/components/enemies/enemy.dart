// lib/game/enemies/enemy.dart

import 'package:flame/components.dart';

// Kelas dasar untuk semua musuh
abstract class Enemy extends SpriteAnimationComponent with HasGameRef {
  final String name;
  int maxHp;
  int currentHp;
  int attack;

  Enemy({
    required this.name,
    required this.maxHp,
    required this.attack,
    super.position,
    super.animation,
  }) : currentHp = maxHp, super(anchor: Anchor.center);

  bool get isDefeated => currentHp <= 0;

  void takeDamage(int amount) {
    currentHp -= amount;
    if (currentHp < 0) {
      currentHp = 0;
    }
    // TODO: Tambahkan efek visual saat terkena damage
  }
}