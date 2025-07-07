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
    Vector2? position,
    SpriteAnimation? animation,
  }) : currentHp = maxHp, super(position: position, animation: animation, anchor: Anchor.center);

  bool get isDefeated => currentHp <= 0;

  void takeDamage(int amount) {
    currentHp -= amount;
    if (currentHp < 0) {
      currentHp = 0;
    }
    // TODO: Tambahkan efek visual saat terkena damage
  }
}