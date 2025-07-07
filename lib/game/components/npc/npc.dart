import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:ruins_legacy/game/components/enemies/enemy.dart';
import 'package:ruins_legacy/game/ruins.dart';
import 'package:ruins_legacy/managers/data_managers.dart';

// PERBAIKAN: Kelas ini sekarang bersih dan hanya bergantung pada NpcData.
class Npc extends SpriteComponent with HasGameRef<RuinsGame>, CollisionCallbacks {
  final NpcData data;

  Npc({
    required this.data,
    super.position,
  }) : super(anchor: Anchor.center);

  // Getter untuk kemudahan akses data dari luar kelas
  String get dialogue => data.dialogue;
  bool get isEnemy => data.isEnemy;

  // Getter ini secara dinamis membuat fungsi untuk menciptakan musuh
  // berdasarkan ID dari file JSON.
  Enemy Function()? get enemyType {
    if (data.isEnemy && data.enemyId != null) {
      // Minta DataManager untuk membuat instance musuh yang sesuai
      // Perbaikan: gameRef adalah RuinsGame, jadi tidak perlu .game lagi
      return () => gameRef.dataManager.createEnemyById(data.enemyId!);
    }
    return null;
  }

  @override
  Future<void> onLoad() async {
    // Muat sprite berdasarkan path dari file JSON
    sprite = await gameRef.loadSprite(data.sprite);
    size = sprite!.originalSize; // Atur ukuran komponen sesuai ukuran sprite
    add(RectangleHitbox());
    return super.onLoad();
  }
}
