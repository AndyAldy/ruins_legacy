import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:ruins_legacy/game/components/npc/npc.dart';
import 'package:ruins_legacy/game/components/worlds/collision_block.dart';
import 'package:ruins_legacy/game/ruins.dart';

class OverworldScreen extends Component with HasGameRef<RuinsGame> {
  @override
  void onMount() {
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
      // PERBAIKAN: Logika spawning yang benar dan berbasis data.
      for (final obj in spawnLayer.objects) {
        if (obj.name == 'Player') {
          game.player.position = Vector2(obj.x, obj.y);
          add(game.player);
        } else {
          // Ambil data NPC dari DataManager berdasarkan nama objek di peta Tiled.
          final npcData = game.dataManager.getNpcByMapName(obj.name);
          if (npcData != null) {
            // Jika data ditemukan, buat NPC berdasarkan data tersebut.
            add(Npc(
              data: npcData,
              position: Vector2(obj.x, obj.y),
            ));
          }
        }
      }
    }

    return super.onLoad();
  }
  @override
  void onRemove() {
    // Simpan posisi pemain saat ini sebelum menghapus komponen.
    gameRef.lastPlayerPosition = gameRef.player.position;
    super.onRemove();
  }
}