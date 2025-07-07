import 'package:flame/components.dart';
import 'package:ruins_legacy/game/components/enemies/enemy.dart';
import 'package:ruins_legacy/managers/data_managers.dart';

class Boss1 extends Enemy {
  // PERBAIKAN: Konstruktor sekarang HANYA menerima EnemyData.
  final EnemyData data;

  Boss1({required this.data, required EnemyData EnemyData})
      : super(
          // PERBAIKAN: Nilai diambil dari 'data', bukan di-hardcode.
          name: data.name,
          maxHp: data.maxHp,
          attack: data.attack,
          defense: data.defense,
        );

  @override
  Future<void> onLoad() async {
    // Menggunakan path sprite dari DataManager.
    sprite = await gameRef.loadSprite(data.sprite);
    size = Vector2.all(64); // Ukuran bisa disesuaikan atau diambil dari data juga
    return super.onLoad();
  }
}
