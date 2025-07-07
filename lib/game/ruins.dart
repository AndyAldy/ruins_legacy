// lib/game/ruins.dart

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ruins_legacy/game/components/player/player.dart';
import 'package:ruins_legacy/game/routes/battle_route.dart';
import 'package:ruins_legacy/game/routes/overworld_route.dart';
import 'package:ruins_legacy/widgets/dialogue_box.dart';

class RuinsGame extends FlameGame with HasCollisionDetection, KeyboardEvents {
  late final CameraComponent cam;
  late final RouterComponent router;
  
  // Perbaikan 1: Inisialisasi Player tanpa argumen.
  // Posisinya akan diatur oleh OverworldRoute.
  Player player = Player();

  bool isDialogueVisible = false;

  @override
  Future<void> onLoad() async {
    // Muat semua aset di awal
    await images.loadAll([
      'player_spritesheet.png',
      'npc.png',
      'enemy_sprite.png',
    ]);

    // Setup kamera
    cam = CameraComponent.withFixedResolution(world: this, width: 640, height: 360);
    cam.viewfinder.zoom = 1.5;
    add(cam);

    // Setup router
    add(
      router = RouterComponent(
        initialRoute: 'overworld',
        routes: {
          'overworld': Route(OverworldRoute.new),
          'battle': Route(BattleRoute.new),
        },
      ),
    );
  }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is RawKeyDownEvent) {
      if (keysPressed.contains(LogicalKeyboardKey.space)) {
        if (isDialogueVisible) {
          // Hapus dialog dari viewport kamera, bukan dari game root.
          cam.viewport.removeWhere((component) => component is DialogueBox);
          isDialogueVisible = false;
        } else {
          // Cari player di dalam route aktif untuk interaksi
          (router.currentRoute.children.whereType<Player>().firstOrNull)?.interact();
        }
        return KeyEventResult.handled;
      }
      
      // Tombol 'Q' untuk kabur dari pertarungan (jika sedang di battle)
      if (keysPressed.contains(LogicalKeyboardKey.keyQ)) {
        if (router.currentRoute.keyName == 'battle') {
          endBattle();
          return KeyEventResult.handled;
        }
      }
    }
    return super.onKeyEvent(event as KeyEvent, keysPressed);
  }

  // Perbaikan 2 & 3: Pindahkan metode ke DALAM kelas dan perbaiki `game.size`.
  void showDialogue(String text) {
    if (!isDialogueVisible) {
      // Gunakan 'size' bukan 'game.size' dan tambahkan ke viewport kamera.
      cam.viewport.add(DialogueBox(text: text, gameSize: size)); 
      isDialogueVisible = true;
    }
  }
  
  // Perbaikan 2: Pindahkan metode ini juga ke dalam kelas.
  void endBattle() {
    router.pop(); // Kembali ke route sebelumnya (overworld)
    // Anda bisa mengatur ulang posisi player di sini jika perlu,
    // atau biarkan OverworldRoute yang menanganinya saat 'onPush'.
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Pastikan kamera selalu mengikuti player jika player ada di overworld
    if (router.currentRoute.keyName == 'overworld' && player.isMounted) {
      cam.follow(player);
    }
  }
}