import 'package:flame/components.dart';
import 'package:ruins_legacy/game/components/enemies/enemy.dart';
import 'package:ruins_legacy/managers/data_managers.dart';

class Boss1 extends Enemy {
  // PERBAIKAN: Konstruktor sekarang HANYA menerima EnemyData.
  final EnemyData data;

  Boss1(this.data, {required EnemyData, required EnemyData data})
      : super(
          // PERBAIKAN: Nilai diambil dari 'data', bukan di-hardcode.
          name: data.name,
          maxHp: data.maxHp,
          attack: data.attack,
          defense: data.defense,
        );

  @override
  Future<void> onLoad() async {
    // PERBAIKAN: Gunakan 'loadSprite' untuk gambar diam, bukan 'loadSpriteAnimation'.
    // Path gambar diambil dari data.sprite, yang berasal dari file enemies.json.
    sprite = await gameRef.loadSprite(data.sprite);
    
    // Atur ukuran komponen setelah sprite dimuat.
    size = Vector2.all(64); // Anda bisa sesuaikan ukuran ini
    return super.onLoad();
  }
}
