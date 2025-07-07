// lib/game/routes/overworld_route.dart

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/widgets.dart';
import 'package:ruins_legacy/game/components/collision_block.dart';
import 'package:ruins_legacy/game/components/enemies/keroco.dart';
import 'package:ruins_legacy/game/components/npc/npc.dart';
import 'package:ruins_legacy/game/ruins.dart';
import 'package:ruins_legacy/game/components/worlds/collision_block.dart';
import 'package:ruins_legacy/game/components/enemies/keroco.dart'; // Import musuh

class OverworldRoute extends Route {
  OverworldRoute() : super(OverworldScreen.new, transparent: false);

  @override
  void onPush(Route? previousRoute, dynamic game) {
    // Saat kembali ke overworld, posisikan ulang player dan aktifkan gerakannya.
    game.player.position = game.lastPlayerPosition;
    game.player.canMove = true;
  }
}

class OverworldScreen extends Component with HasGameRef<RuinsGame> {
  @override
  Future<void> onLoad() async {
    final map = await TiledComponent.load('map.tmx', Vector2.all(16));
    add(map);

    final collisionLayer = map.tileMap.getLayer<ObjectGroup>('Collisions');
    if (collisionLayer != null) {
      for (final obj in collisionLayer.objects) {
        add(CollisionBlock(position: Vector2(obj.x, obj.y), size: Vector2(obj.width, obj.height)));
      }
    }

    final spawnLayer = map.tileMap.getLayer<ObjectGroup>('Spawns');
    if (spawnLayer != null) {
      for (final obj in spawnLayer.objects) {
        switch (obj.name) {
          case 'Player':
            game.player.position = Vector2(obj.x, obj.y);
            add(game.player);
            break;
          case 'Npc':
            add(Npc(
                position: Vector2(obj.x, obj.y),
                dialogue: "Zzz... jangan ganggu aku..."));
            break;
          case 'Enemy':
            add(Npc(
                position: Vector2(obj.x, obj.y),
                dialogue: "Grrr... kau menantangku?",
                isEnemy: true,
                enemyType: Keroco // Tentukan tipe musuh di sini
            ));
            break;
        }
      }
    }
    
    return super.onLoad();
  }
}