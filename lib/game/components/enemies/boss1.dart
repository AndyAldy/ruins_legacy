// lib/game/components/enemies/enemy.dart
import 'package:flame/components.dart';
import 'package:ruins_legacy/game/ruins.dart';
import 'package:ruins_legacy/managers/data_managers.dart'; // Import RuinsGame
class Boss1 extends Enemy {
  Boss1({Vector2? position, required EnemyData data})
      : super(
          name: 'Guardian Golem',
          maxHp: 150,
          attack: 10,
          position: position,
        );

  @override
  Future<void> onLoad() async {
    // 'gameRef' sekarang tersedia di sini
    sprite = await gameRef.loadSprite('npc.png'); // Ganti dengan sprite boss nanti
    size = Vector2.all(64);
    return super.onLoad();
  }
}

abstract class Enemy extends SpriteComponent with HasGameRef<RuinsGame> {
  // ... sisa kode tidak berubah
  final String name;
  final int maxHp;
  int hp;
  final int attack;
  final int defense;

  Enemy({
    required this.name,
    required this.maxHp,
    required this.attack,
    this.defense = 0,
    super.position,
  })  : hp = maxHp;

  bool get isDefeated => hp <= 0;

  void takeDamage(int amount) {
    hp -= amount;
    if (hp < 0) {
      hp = 0;
    }
  }
}