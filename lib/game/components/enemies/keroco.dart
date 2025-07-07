import 'package:flame/components.dart';
import 'package:ruins_legacy/game/components/enemies/enemy.dart';
import 'package:ruins_legacy/managers/data_managers.dart';

class Keroco extends Enemy {
  final EnemyData data;
  // PERBAIKAN: Ubah konstruktor untuk menerima EnemyData.
  Keroco(this.data, {required EnemyData, required EnemyData data})
      : super(
          // Nilai diambil dari 'data', bukan di-hardcode.
          name: data.name,
          maxHp: data.maxHp,
          attack: data.attack,
          defense: data.defense,
        );

  @override
  Future<void> onLoad() async {
    animation = await gameRef.loadSpriteAnimation(
      'sprite/enemies/keroco.png', // Anda bisa ganti ini dengan data.sprite
      SpriteAnimationData.sequenced(
        amount: 4, // Jumlah frame animasi
        stepTime: 0.2,
        textureSize: Vector2(32, 32), // Ukuran satu frame
      ),
    );
    return super.onLoad();
  }
}
