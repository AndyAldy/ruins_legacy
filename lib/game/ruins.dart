// lib/game/ruins.dart
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ruins_legacy/game/components/player.dart';
import 'package:ruins_legacy/game/components/collision_block.dart';

class RuinsGame extends FlameGame with HasCollisionDetection, KeyboardHandler {
  late final CameraComponent cam;
  late TiledComponent map;
  late Player player;

  @override
  Future<void> onLoad() async {
    // Memuat semua gambar ke cache untuk akses cepat
    await images.loadAll(['player_spritesheet.png']);

    // Muat peta Tiled
    map = await TiledComponent.load('map.tmx', Vector2.all(16));
    add(map);

    // Ambil layer 'Collisions' dari peta
    final collisionLayer = map.tileMap.getLayer<ObjectGroup>('Collisions');
    if (collisionLayer != null) {
      for (final collision in collisionLayer.objects) {
        add(CollisionBlock(
          position: Vector2(collision.x, collision.y),
          size: Vector2(collision.width, collision.height),
        ));
      }
    }

    // Tambahkan pemain
    player = Player();
    add(player);
    
    // Atur posisi awal pemain
    player.position = Vector2(200, 200);

    // Atur kamera untuk mengikuti pemain
    cam = CameraComponent.withFixedResolution(
        width: 640, height: 360, world: this);
    cam.viewfinder.follow(player);
    cam.viewfinder.zoom = 1.5; // Atur zoom sesuai selera
    add(cam);
  }

  // Override onKeyEvent untuk meneruskan event ke player
  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);
    return player.onKeyEvent(event, keysPressed);
  }
}