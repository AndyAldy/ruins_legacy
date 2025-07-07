// lib/game/worlds/collision_block.dart

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

// Blok tak terlihat untuk menangani tabrakan dengan lingkungan.
class CollisionBlock extends PositionComponent with CollisionCallbacks {
  CollisionBlock({required Vector2 position, required Vector2 size})
      : super(position: position, size: size) {
    // debugMode = true; // Aktifkan untuk melihat hitbox
  }

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // Logika untuk menangani tabrakan dengan objek lain
    super.onCollision(intersectionPoints, other);
  }
}