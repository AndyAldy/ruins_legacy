import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:ruins_legacy/game/components/npc/npc.dart';
import 'package:ruins_legacy/game/ruins.dart';
import 'package:ruins_legacy/models/dialogue_node.dart';

enum PlayerState { idle, running }

class Player extends SpriteAnimationGroupComponent<PlayerState>
    with KeyboardHandler, CollisionCallbacks, HasGameRef<RuinsGame> {
  final double _speed = 150;
  Vector2 _direction = Vector2.zero();
  bool canMove = true;
  Npc? _collidingNpc;

  Player() : super(size: Vector2(32, 48), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    final spriteSheet = await gameRef.images.load('sprite/players/player_spritesheet.png');
    animations = {
      PlayerState.idle: SpriteAnimation.fromFrameData(
          spriteSheet,
          SpriteAnimationData.sequenced(
              amount: 1, textureSize: Vector2(32, 48), stepTime: 1)),
      PlayerState.running: SpriteAnimation.fromFrameData(
          spriteSheet,
          SpriteAnimationData.sequenced(
              amount: 4, textureSize: Vector2(32, 48), stepTime: 0.15)),
    };
    current = PlayerState.idle;
    add(RectangleHitbox.relative(Vector2(0.8, 0.5), parentSize: size)
      ..position = Vector2(size.x * 0.1, size.y * 0.5));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (canMove && _direction != Vector2.zero()) {
      _direction.normalize();
      position += _direction * _speed * dt;
    }
    super.update(dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    _direction = Vector2.zero();
    if (canMove) {
      final isUp = keysPressed.contains(LogicalKeyboardKey.keyW) ||
          keysPressed.contains(LogicalKeyboardKey.arrowUp);
      final isDown = keysPressed.contains(LogicalKeyboardKey.keyS) ||
          keysPressed.contains(LogicalKeyboardKey.arrowDown);
      final isLeft = keysPressed.contains(LogicalKeyboardKey.keyA) ||
          keysPressed.contains(LogicalKeyboardKey.arrowLeft);
      final isRight = keysPressed.contains(LogicalKeyboardKey.keyD) ||
          keysPressed.contains(LogicalKeyboardKey.arrowRight);

      _direction.y += isUp ? -1 : 0;
      _direction.y += isDown ? 1 : 0;
      _direction.x += isLeft ? -1 : 0;
      _direction.x += isRight ? 1 : 0;
    }

    current = _direction.isZero() ? PlayerState.idle : PlayerState.running;
    if (_direction.x != 0) {
      if ((scale.x > 0 && _direction.x < 0) || (scale.x < 0 && _direction.x > 0)) {
        flipHorizontally();
      }
    }
    return true;
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Npc) {
      _collidingNpc = other;
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is Npc && other == _collidingNpc) {
      _collidingNpc = null;
    }
    super.onCollisionEnd(other);
  }

  void interact() {
    if (_collidingNpc != null) {
      if (_collidingNpc!.isEnemy) {
        final enemyBuilder = _collidingNpc!.enemyType;
        // Pemeriksaan null yang aman
        if (enemyBuilder != null) {
          gameRef.startBattle(enemyBuilder);
        }
      } else {
        gameRef.dialogueSystem.showDialogue(DialogueNode(text: _collidingNpc!.dialogue));
      }
    }
  }
}
