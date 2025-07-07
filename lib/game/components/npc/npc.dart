// lib/game/components/npc.dart
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:ruins_legacy/game/components/enemies/keroco.dart';

class Npc extends SpriteComponent with CollisionCallbacks {
  final String dialogue;
  final bool isEnemy;

  final bool enemyType;

  Npc(this.enemyType, {
    super.position,
    super.size,
    required this.dialogue,
    this.isEnemy = false, required Keroco Function({Vector2? position}) Function() enemyBuilder, required Keroco Function({Vector2? position}) enemyType,
  }) : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    // Anda bisa menggunakan sprite berbeda jika NPC adalah musuh
    sprite = await Sprite.load(isEnemy ? 'enemy_sprite.png' : 'npc.png'); 
    add(RectangleHitbox());
  }
}