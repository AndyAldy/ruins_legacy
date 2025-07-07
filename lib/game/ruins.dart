import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/src/camera/viewfinder.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ruins_legacy/game/components/player/player.dart';
import 'package:ruins_legacy/game/components/collision_block.dart';
import 'package:ruins_legacy/widgets/dialogue_box.dart';
import 'package:ruins_legacy/game/components/npc/npc.dart';
import 'package:ruins_legacy/screens/battle.dart';

enum GameState { overworld, battle }

class RuinsGame extends FlameGame with HasCollisionDetection, KeyboardEvents {
  late final CameraComponent cam;
  late TiledComponent map;
  late Player player;
  bool isDialogueVisible = false;
  GameState gameState = GameState.overworld;

  final List<Component> _overworldComponents = [];

  @override
  Future<void> onLoad() async {
    await images.loadAll(['player_spritesheet.png', 'npc.png', 'enemy_sprite.png']);

    cam = CameraComponent.withFixedResolution(world: this, width: 640, height: 360);
    cam.viewfinder.zoom = 1.5;
    add(cam);

    map = await TiledComponent.load('map.tmx', Vector2.all(16));
    add(map);

    final collisionLayer = map.tileMap.getLayer<ObjectGroup>('Collisions');
    if (collisionLayer != null) {
      for (final collision in collisionLayer.objects) {
        add(CollisionBlock(
          position: Vector2(collision.x, collision.y),
          size: Vector2(collision.width, collision.height),
        ));
      }
    }
    
    add(Npc(
      position: Vector2(300, 250),
      dialogue: "Halo, petualang... Selamat datang di reruntuhan kuno ini.",
    ));
    add(Npc(
      position: Vector2(400, 200),
      dialogue: "Grrr... Bersiaplah!",
      isEnemy: true,
    ));

    player = Player(position: Vector2(200, 200));
    add(player);
    
    cam.viewfinder.follow(player);
  }

  void startBattle() {
    if (gameState == GameState.overworld) {
      gameState = GameState.battle;
      _overworldComponents.clear();
      _overworldComponents.addAll(children.where((c) => c is! CameraComponent && c is! BattleScreen));
      for (final component in _overworldComponents) {
        component.removeFromParent();
      }
      add(BattleScreen());
    }
  }

  void endBattle() {
    if (gameState == GameState.battle) {
      gameState = GameState.overworld;
      removeWhere((component) => component is BattleScreen);
      addAll(_overworldComponents);
    }
  }

  @override
  KeyEventResult onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (gameState == GameState.battle) {
      if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.keyQ) {
        endBattle();
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    }

    if (event is RawKeyDownEvent) {
      if (keysPressed.contains(LogicalKeyboardKey.space)) {
        if (isDialogueVisible) {
          removeWhere((component) => component is DialogueBox);
          isDialogueVisible = false;
        } else {
          player.interact();
        }
        return KeyEventResult.handled;
      }
    }
    
    return super.onKeyEvent(event as KeyEvent, keysPressed);
  }

  void showDialogue(String text) {
    if (!isDialogueVisible) {
      add(DialogueBox(text: text));
      isDialogueVisible = true;
    }
  }
}

extension on Viewfinder {
  void follow(Player player) {}
}
