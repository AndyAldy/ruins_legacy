// lib/game/components/player.dart
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:ruins_legacy/game/ruins.dart';
import 'package:ruins_legacy/game/components/npc/npc.dart';
import 'package:ruins_legacy/widgets/dialogue_box.dart';

class Player extends SpriteAnimationComponent
    with KeyboardHandler, HasGameRef<RuinsGame>, CollisionCallbacks {
  final double _playerSpeed = 200.0;
  final Vector2 _velocity = Vector2.zero();
  Npc? collidingNpc;

  // Animasi untuk setiap arah
  late final SpriteAnimation _runDownAnimation;
  late final SpriteAnimation _runLeftAnimation;
  late final SpriteAnimation _runUpAnimation;
  late final SpriteAnimation _runRightAnimation;
  late final SpriteAnimation _standingAnimation;

  Player({required Vector2 position}) : super(size: Vector2.all(64.0), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    // Muat semua animasi dari satu spritesheet
    final spriteSheet = SpriteSheet(
      image: await game.images.load('player_spritesheet.png'), // Anda perlu siapkan gambar ini
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

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);
    final isUpKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyW) ||
        keysPressed.contains(LogicalKeyboardKey.arrowUp);
    final isDownKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyS) ||
        keysPressed.contains(LogicalKeyboardKey.arrowDown);

    // Atur kecepatan berdasarkan tombol yang ditekan
    _velocity.x = 0;
    _velocity.y = 0;
    if (isLeftKeyPressed) {
      _velocity.x = -_playerSpeed;
      animation = _runLeftAnimation;
    }
    if (isRightKeyPressed) {
      _velocity.x = _playerSpeed;
      animation = _runRightAnimation;
    }
    if (isUpKeyPressed) {
      _velocity.y = -_playerSpeed;
      animation = _runUpAnimation;
    }
    if (isDownKeyPressed) {
      _velocity.y = _playerSpeed;
      animation = _runDownAnimation;
    }
    
    // Jika tidak ada tombol gerakan ditekan, kembali ke animasi berdiri
    if (!isLeftKeyPressed && !isRightKeyPressed && !isUpKeyPressed && !isDownKeyPressed) {
      animation = _standingAnimation;
    }

    return true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Gerakkan pemain berdasarkan kecepatan
    position += _velocity * dt;
  }
  
  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Npc) {
      collidingNpc = other;
      void interact() {
    if (collidingNpc != null) {
      gameRef.showDialogue(collidingNpc!.dialogue);
    }
  }
}
    // Jika bertabrakan dengan sesuatu (misal: dinding), berhenti
    if (other is ScreenHitbox) {
      // Anda bisa tambahkan logika untuk dinding spesifik di sini
    }
  }
}