import 'package:flame/components.dart';
import 'package:ruins_legacy/game/ruins.dart';

// Ini adalah SATU-SATUNYA kelas dasar untuk semua musuh.
// Menggunakan SpriteAnimationComponent agar semua musuh bisa beranimasi.
abstract class Enemy extends SpriteAnimationComponent with HasGameRef<RuinsGame> {
  final String name; // Menggunakan 'name' agar konsisten
  final int maxHp;
  int hp;
  final int attack;
  final int defense;

  Enemy({
    required this.name, // Menggunakan 'name'
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
