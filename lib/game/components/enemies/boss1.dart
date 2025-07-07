import 'package:flame/components.dart';
import 'package:ruins_legacy/game/components/enemies/enemy.dart';
import 'package:ruins_legacy/managers/data_managers.dart';

class Boss1 extends Enemy {
  final EnemyData data;

  Boss1({required this.data})
      : super(
          name: data.name,
          maxHp: data.maxHp,
          attack: data.attack,
          defense: data.defense,
        );

  @override
  Future<void> onLoad() async {
    // PERBAIKAN: Muat gambar sebagai animasi 1 frame, bukan sebagai sprite tunggal
    animation = await gameRef.loadSpriteAnimation(
      data.sprite, // Path ke file gambar golem
      SpriteAnimationData.sequenced(
        amount: 1, // Jumlah frame dalam animasi (hanya 1)
        stepTime: 1, // Tidak penting karena hanya 1 frame
        textureSize: Vector2(64, 64), // Sesuaikan dengan ukuran asli gambar golem-mu
      ),
    );
    return super.onLoad();
  }
}