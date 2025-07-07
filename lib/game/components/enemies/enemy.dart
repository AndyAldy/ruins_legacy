import 'package:flame/components.dart';
import 'package:ruins_legacy/game/ruins.dart';

// Ini adalah SATU-SATUNYA kelas dasar untuk semua musuh.
// Pastikan tidak ada definisi kelas Enemy lain di proyek Anda.
abstract class Enemy extends SpriteAnimationComponent with HasGameRef<RuinsGame> {
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
  })  : hp = maxHp,
        super(anchor: Anchor.center);

  bool get isDefeated => hp <= 0;

  void takeDamage(int damage) {
    final effectiveDamage = (damage - defense).clamp(0, 999);
    hp -= effectiveDamage;
    if (hp < 0) {
      hp = 0;
    }
  }
}
