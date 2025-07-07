// lib/game/player_heart.dart

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'package:ruins_legacy/game/components/collision_block.dart';

// 'Jiwa' pemain yang digerakkan saat fase bertahan
class PlayerHeart extends PositionComponent with HasGameRef, CollisionCallbacks {
  final _paint = Paint()..color = Colors.red;
  Vector2 velocity = Vector2.zero();
  double speed = 200.0;

  PlayerHeart({required Vector2 position, required Vector2 size})
      : super(position: position, size: size, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), _paint);
  }

  @override
  void update(double dt) {
    position += velocity * speed * dt;
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // Logika untuk menangani tabrakan dengan musuh atau objek lain
    if (other is CollisionBlock) {
      // Misalnya, jika bertabrakan dengan CollisionBlock, hentikan gerakan
      velocity = Vector2.zero();
    }
    super.onCollision(intersectionPoints, other);
  }
}