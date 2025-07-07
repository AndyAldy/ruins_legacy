// lib/game/components/enemies/enemy.dart
import 'package:flame/components.dart';
import 'package:ruins_legacy/game/ruins.dart'; // Import RuinsGame
import 'package:ruins_legacy/models/game_data.dart';
import 'package:ruins_legacy/game/components/enemies/enemy.dart';

class Boss1 extends Enemy {
  Boss1({super.position})
      : super(
          name: 'Guardian Golem',
          maxHp: 150,
          attack: 10,
        );

  @override
  Future<void> onLoad() async {
    // Ganti dengan aset sprite untuk boss dan gunakan gameRef
    sprite = await gameRef.loadSprite('npc.png');
    size = Vector2.all(64);
    await super.onLoad();
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