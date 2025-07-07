// lib/game/components/npc.dart
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Npc extends SpriteComponent with CollisionCallbacks {
  final String dialogue;

  Npc({
    super.position,
    super.size,
    required this.dialogue,
  }) : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('npc.png'); // Pastikan Anda punya gambar ini
    add(RectangleHitbox());
  }
}