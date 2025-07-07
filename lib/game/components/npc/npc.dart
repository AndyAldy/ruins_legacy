import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:ruins_legacy/game/components/enemies/enemy.dart';

class Npc extends SpriteComponent with HasGameRef, CollisionCallbacks {
  final String dialogue;
  final bool isEnemy;
  // Ini adalah fungsi yang akan membuat instance musuh.
  // Bisa null jika NPC ini bukan musuh.
  final Enemy Function()? enemyType;

  Npc({
    required this.dialogue,
    this.isEnemy = false,
    this.enemyType,
    super.position,
    super.size,
  }) : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    // Menggunakan path aset yang benar dari struktur folder Anda
    final spritePath = isEnemy ? 'sprite/enemies/keroco.png' : 'sprite/players/player_spritesheet.png'; // Ganti dengan sprite NPC yang sesuai
    sprite = await gameRef.loadSprite(spritePath);
    add(RectangleHitbox());
    return super.onLoad();
  }
}
