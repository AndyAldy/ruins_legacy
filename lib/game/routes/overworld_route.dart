import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:ruins_legacy/game/components/collision_block.dart';
import 'package:ruins_legacy/game/components/enemies/keroco.dart';
import 'package:ruins_legacy/game/components/npc/npc.dart';
import 'package:ruins_legacy/game/ruins.dart';

// Dengan API router Flame yang baru, kita tidak lagi memerlukan class 'OverworldRoute'.
// Kita hanya perlu komponen layarnya saja.

class OverworldScreen extends Component with HasGameRef<RuinsGame> {
  @override
  void onMount() {
    // Logika yang sebelumnya ada di onPush() dipindahkan ke sini.
    // onMount() berjalan setiap kali komponen ini ditambahkan/diaktifkan.
    final game = gameRef;
    if (game.lastPlayerPosition != Vector2.zero()) {
      game.player.position = game.lastPlayerPosition;
    }
    game.player.canMove = true;
    super.onMount();
  }

  @override
  Future<void> onLoad() async {
    final map = await TiledComponent.load('map.tmx', Vector2.all(16));
    add(map);

    final collisionLayer = map.tileMap.getLayer<ObjectGroup>('Collisions');
    if (collisionLayer != null) {
      for (final obj in collisionLayer.objects) {
        add(CollisionBlock(
            position: Vector2(obj.x, obj.y),
            size: Vector2(obj.width, obj.height)));
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
                enemyType: Keroco.new));
            break;
        }
      }
    }

    return super.onLoad();
  }
}
