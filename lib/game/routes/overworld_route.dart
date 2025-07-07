import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/widgets.dart';
import 'package:ruins_legacy/game/components/collision_block.dart';
import 'package:ruins_legacy/game/components/npc/npc.dart';
import 'package:ruins_legacy/game/ruins.dart';

class OverworldRoute extends Route {
  OverworldRoute() : super(OverworldScreen.new);

  @override
  void onPush(Route? previousRoute) {
    // Logika saat masuk ke overworld
    // Misalnya, memposisikan ulang player
    game.player.position = Vector2(200, 200);
  }
}

class OverworldScreen extends Component with HasGameRef<RuinsGame> {
  late TiledComponent map;

  @override
  Future<void> onLoad() async {
    map = await TiledComponent.load('map.tmx', Vector2.all(16));
    add(map);

    // Tambahkan collision
    final collisionLayer = map.tileMap.getLayer<ObjectGroup>('Collisions');
    if (collisionLayer != null) {
      for (final collision in collisionLayer.objects) {
        add(CollisionBlock(
          position: Vector2(collision.x, collision.y),
          size: Vector2(collision.width, collision.height),
        ));
      }
    }

    // Tambahkan NPC dan player
    add(Npc(
      position: Vector2(300, 250),
      dialogue: "Halo, petualang... Selamat datang di reruntuhan kuno ini.",
    ));
    add(Npc(
      position: Vector2(400, 200),
      dialogue: "Grrr... Bersiaplah!",
      isEnemy: true,
    ));

    // Tambahkan player yang sudah ada di game utama
    add(game.player);
  }
}