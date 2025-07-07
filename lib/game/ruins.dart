// lib/game/ruins.dart
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ruins_legacy/game/components/player/player.dart';
import 'package:ruins_legacy/game/components/collision_block.dart';
import 'package:flutter/services.dart';
import 'package:ruins_legacy/widgets/dialogue_box.dart';
import 'package:ruins_legacy/game/components/npc/npc.dart';

class RuinsGame extends FlameGame with HasCollisionDetection, KeyboardHandler {
  late final CameraComponent cam;
  late TiledComponent map;
  late Player player;
  bool isDialogueVisible = false;

  @override
  Future<void> onLoad() async {
        add(Npc(
      position: Vector2(300, 250),
      size: Vector2.all(64.0),
      dialogue: "Halo, petualang... Selamat datang di reruntuhan kuno ini.",
    ));
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
    // Meneruskan event gerakan ke player
    player.onKeyEvent(event, keysPressed);
        if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.space) {
        if (isDialogueVisible) {
          // Jika dialog sedang tampil, sembunyikan
          removeWhere((component) => component is DialogueBox);
          isDialogueVisible = false;
        } else {
          // Jika tidak, cek apakah player bisa berinteraksi
          player.interact();
        }
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }
    void showDialogue(String text) {
    if (!isDialogueVisible) {
      add(DialogueBox(text: text, gameSize: size));
      isDialogueVisible = true;
    }
  }
}
