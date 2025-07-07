// lib/game/components/npc.dart
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Npc extends SpriteComponent with CollisionCallbacks {
  final String dialogue;
  final bool isEnemy;

  Npc({
    super.position,
    super.size,
    required this.dialogue,
    this.isEnemy = false,
  }) : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    // Anda bisa menggunakan sprite berbeda jika NPC adalah musuh
    sprite = await Sprite.load(isEnemy ? 'enemy_sprite.png' : 'npc.png'); 
    add(RectangleHitbox());
  }
}