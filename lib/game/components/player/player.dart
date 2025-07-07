import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ruins_legacy/game/components/npc/npc.dart';
import 'package:ruins_legacy/game/ruins.dart';

// GANTI KeyboardHandler menjadi KeyboardEvents
class Player extends SpriteAnimationComponent
    with HasGameRef<RuinsGame>, CollisionCallbacks, KeyboardEvents {
  final double _playerSpeed = 200.0;
  Vector2 _velocity = Vector2.zero();

  late final SpriteAnimation _runDownAnimation;
  late final SpriteAnimation _runLeftAnimation;
  late final SpriteAnimation _runUpAnimation;
  late final SpriteAnimation _runRightAnimation;
  late final SpriteAnimation _standingAnimation;

  Npc? _collidingNpc;

  Player({required Vector2 position})
      : super(position: position, size: Vector2.all(48.0), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    final spriteSheet = SpriteSheet(
      image: await game.images.load('player_spritesheet.png'),
      srcSize: Vector2(32.0, 32.0),
    );

    _runDownAnimation = spriteSheet.createAnimation(row: 0, stepTime: 0.1, to: 4);
    _runLeftAnimation = spriteSheet.createAnimation(row: 1, stepTime: 0.1, to: 4);
    _runUpAnimation = spriteSheet.createAnimation(row: 2, stepTime: 0.1, to: 4);
    _runRightAnimation = spriteSheet.createAnimation(row: 3, stepTime: 0.1, to: 4);
    _standingAnimation = spriteSheet.createAnimation(row: 0, stepTime: 0.1, to: 1);

    animation = _standingAnimation;
    add(RectangleHitbox());
  }

  // GANTI tipe return dari bool ke KeyEventResult
  KeyEventResult onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    _velocity = Vector2.zero();

    // Logika gerakan tetap sama
    if (keysPressed.contains(LogicalKeyboardKey.keyA) || keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      _velocity.x = -_playerSpeed;
      animation = _runLeftAnimation;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyD) || keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      _velocity.x = _playerSpeed;
      animation = _runRightAnimation;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyW) || keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      _velocity.y = -_playerSpeed;
      animation = _runUpAnimation;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyS) || keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      _velocity.y = _playerSpeed;
      animation = _runDownAnimation;
    } else {
      animation = _standingAnimation;
    }

    // GANTI return true menjadi KeyEventResult.handled
    return KeyEventResult.handled;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += _velocity * dt;
  }

  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Npc) {
      _collidingNpc = other;
    }
  }

  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is Npc) {
      _collidingNpc = null;
    }
  }

void interact() {
  if (_collidingNpc != null) {
    if (_collidingNpc!.isEnemy) {
      // Ganti gameRef.startBattle() menjadi:
      gameRef.router.pushNamed('battle');
    } else {
      gameRef.showDialogue(_collidingNpc!.dialogue);
    }
  }
}
}
