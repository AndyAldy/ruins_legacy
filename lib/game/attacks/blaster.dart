import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ruins_legacy/game/components/player/player_heart.dart';
import 'package:ruins_legacy/game/ruins.dart';

// Contoh serangan sederhana: peluru yang bergerak lurus.
class BlasterBullet extends PositionComponent
    with HasGameRef<RuinsGame>, CollisionCallbacks {
  Vector2 velocity;

  BlasterBullet({
    super.position,
    required this.velocity,
  }) : super(size: Vector2.all(8), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
    add(
      RectangleComponent(
        size: size,
        paint: Paint()..color = Colors.white,
      ),
    );
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position += velocity * dt;

    // PERBAIKAN: Cek batas peluru terhadap viewport kamera.
    // Ini lebih aman daripada bergantung pada 'parent'.
    if (!gameRef.camera.visibleWorldRect.overlaps(toRect())) {
      removeFromParent();
    }
    super.update(dt);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is PlayerHeart) {
      // Kurangi HP pemain melalui game instance
      gameRef.playerData.takeDamage(5); // Contoh damage
      removeFromParent(); // Hancurkan peluru saat mengenai hati
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
