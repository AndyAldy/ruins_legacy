// lib/game/ruins.dart
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ruins_legacy/game/components/player/player.dart';
import 'package:ruins_legacy/game/components/collision_block.dart';
import 'package:ruins_legacy/widgets/dialogue_box.dart';
import 'package:ruins_legacy/game/components/npc/npc.dart';

class RuinsGame extends FlameGame with HasCollisionDetection, KeyboardHandler {
  late final CameraComponent cam;
  late TiledComponent map;
  late Player player;
  bool isDialogueVisible = false;

  @override
  Future<void> onLoad() async {
    // 1. Muat semua aset terlebih dahulu untuk performa yang lebih baik.
    await images.loadAll(['player_spritesheet.png', 'npc.png']);

    // 2. Siapkan kamera dan atur resolusinya.
    cam = CameraComponent.withFixedResolution(width: 640, height: 360, world: this);
    cam.viewfinder.zoom = 1.5; // Atur zoom sesuai selera
    add(cam);

    // 3. Muat peta Tiled.
    map = await TiledComponent.load('map.tmx', Vector2.all(16));
    add(map);

    // 4. Proses layer kolisi dari peta.
    final collisionLayer = map.tileMap.getLayer<ObjectGroup>('Collisions');
    if (collisionLayer != null) {
      for (final collision in collisionLayer.objects) {
        add(CollisionBlock(
          position: Vector2(collision.x, collision.y),
          size: Vector2(collision.width, collision.height),
        ));
      }
    }
    
    // 5. Tambahkan NPC ke dalam game.
    add(Npc(
      position: Vector2(300, 250),
      dialogue: "Halo, petualang... Selamat datang di reruntuhan kuno ini.",
    ));

    // 6. Tambahkan pemain.
    player = Player(position: Vector2(200, 200)); // Berikan posisi awal di sini
    add(player);
    
    // 7. Arahkan kamera untuk mengikuti pemain.
    // Metode 'follow' ada di viewfinder kamera. Ini sudah benar.
    cam.viewfinder.follow(player);
  }

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // Pertama, tangani input untuk dialog (prioritas lebih tinggi)
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.space) {
        if (isDialogueVisible) {
          // Jika dialog tampil, tombol spasi akan menyembunyikannya.
          removeWhere((component) => component is DialogueBox);
          isDialogueVisible = false;
        } else {
          // Jika tidak ada dialog, tombol spasi akan memicu interaksi.
          // Metode 'interact' ada di dalam class Player.
          player.interact();
        }
        return KeyEventResult.handled; // Input sudah ditangani
      }
    }
    
    // Jika input bukan untuk dialog, teruskan ke pemain untuk gerakan.
    // Metode 'onKeyEvent' ada di dalam class Player dengan mixin KeyboardHandler.
    return player.onKeyEvent(event, keysPressed);
  }

  // Fungsi ini dipanggil dari dalam Player saat interaksi berhasil.
  void showDialogue(String text) {
    if (!isDialogueVisible) {
      add(DialogueBox(text: text));
      isDialogueVisible = true;
    }
  }
}