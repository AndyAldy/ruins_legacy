// lib/game/components/collision_block.dart
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class CollisionBlock extends PositionComponent {
  bool isVisible;

  CollisionBlock({
    Vector2? position,
    Vector2? size,
    this.isVisible = false, // Secara default tidak terlihat
  }) : super(position: position, size: size) {
    // debugMode = isVisible; // Hapus komentar ini jika ingin melihat hitbox
  }

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }
}