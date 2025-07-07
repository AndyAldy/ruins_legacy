import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' hide Route;
import 'package:ruins_legacy/game/components/enemies/enemy.dart';
import 'package:ruins_legacy/game/components/player/player.dart';
import 'package:ruins_legacy/game/routes/afterlife_route.dart';
import 'package:ruins_legacy/game/routes/battle_route.dart';
import 'package:ruins_legacy/game/routes/overworld_route.dart';
import 'package:ruins_legacy/game/systems/dialogue_system.dart';
import 'package:ruins_legacy/models/game_data.dart';

class RuinsGame extends FlameGame with HasCollisionDetection, KeyboardEvents {
  late final RouterComponent router;
  late final DialogueSystem dialogueSystem;

  final GameData playerData = GameData();
  final Player player = Player();
  Vector2 lastPlayerPosition = Vector2.zero();

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'sprite/players/player_spritesheet.png',
      'sprite/enemies/keroco.png', // Ganti dengan nama sprite yang benar
      'tilesets/ruins_tileset.png', // Ganti dengan nama tileset yang benar
    ]);

    camera.viewport = FixedResolutionViewport(resolution: Vector2(640, 360));
    camera.viewfinder.zoom = 1.5;

    dialogueSystem = DialogueSystem(this);

    router = RouterComponent(
      initialRoute: 'overworld',
      routes: {
        'overworld': Route(OverworldScreen.new),
        'afterlife': Route(AfterlifeScreen.new),
      },
    );
    add(router);

    return super.onLoad();
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (event is KeyDownEvent) {
      if (keysPressed.contains(LogicalKeyboardKey.space)) {
        if (dialogueSystem.isDialogueVisible) {
          dialogueSystem.hideDialogue();
        } else {
          player.interact();
        }
        return KeyEventResult.handled;
      }
    }
    return super.onKeyEvent(event, keysPressed);
  }

  void startBattle(Enemy Function() enemyBuilder) {
    lastPlayerPosition = player.position.clone();
    player.canMove = false;
    router.pushRoute(BattleRoute(enemyBuilder: enemyBuilder));
  }

  void endBattle({required bool battleWon}) {
    router.pop();
    if (!battleWon) {
      // Jika kalah, pergi ke layar Game Over
      // PERBAIKAN: Metode yang benar adalah 'pushReplacementNamed'
      router.pushReplacementNamed('afterlife');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (router.currentRoute.key == 'overworld' && player.isMounted) {
      camera.follow(player);
    }
  }
}
