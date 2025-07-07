// lib/game/ruins.dart

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' hide Route;
import 'package:ruins_legacy/game/components/player/player.dart';
import 'package:ruins_legacy/game/components/enemies/enemy.dart';
import 'package:ruins_legacy/game/routes/battle_route.dart';
import 'package:ruins_legacy/game/routes/overworld_route.dart';
import 'package:ruins_legacy/models/game_data.dart';
import 'package:ruins_legacy/game/systems/dialogue_system.dart';

class RuinsGame extends FlameGame with HasCollisionDetection, KeyboardEvents {
  late final RouterComponent router;
  late final DialogueSystem dialogueSystem;
  
  // Data utama pemain
  final GameData playerData = GameData();
  final Player player = Player();
  Vector2 lastPlayerPosition = Vector2.zero();

  @override
  Future<void> onLoad() async {
    // Muat semua aset
    await images.loadAll([
      'player_spritesheet.png',
      'npc.png',
      'enemy_sprite.png',
    ]);

    // Setup kamera
    camera.viewport = FixedResolutionViewport(resolution: Vector2(640, 360));
    camera.viewfinder.zoom = 1.5;

    // Inisialisasi sistem
    dialogueSystem = DialogueSystem(this);

    // Setup router
    router = RouterComponent(
      initialRoute: 'overworld',
      routes: {
        'overworld': OverworldRoute(),
        // Battle route akan dibuat secara dinamis
      },
    );
    add(router);

    // Tambahkan komponen global yang tidak ada di dalam route
    // (jika ada)

    return super.onLoad();
  }

  @override
  KeyEventResult onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is RawKeyDownEvent) {
      if (keysPressed.contains(LogicalKeyboardKey.space)) {
        if (dialogueSystem.isDialogueVisible) {
          dialogueSystem.hideDialogue();
        } else {
          player.interact();
        }
        return KeyEventResult.handled;
      }
    }
    // Forward event ke komponen lain (seperti Player)
    return super.onKeyEvent(event as KeyEvent, keysPressed);
  }
  
  void startBattle(Enemy Function() enemyBuilder) {
    // Simpan posisi terakhir player sebelum bertarung
    lastPlayerPosition = player.position.clone();
    player.canMove = false;
    router.pushRoute(BattleRoute(enemyBuilder: enemyBuilder) as Route);
  }

  void endBattle() {
    router.pop();
    // Logika setelah pertarungan (misalnya, beri XP)
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Hanya ikuti player jika dia ada di overworld
    if (router.currentRoute is OverworldRoute && player.isMounted) {
      camera.follow(player);
    }
  }
}