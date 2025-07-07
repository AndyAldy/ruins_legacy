import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/painting.dart';
import 'package:ruins_legacy/game/ruins.dart';

class AfterlifeScreen extends Component with HasGameRef<RuinsGame>, TapCallbacks {
  @override
  Future<void> onLoad() async {
    addAll([
      TextComponent(
        text: 'GAME OVER',
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 64,
            color: Color(0xFFFF0000),
            fontWeight: FontWeight.bold,
          ),
        ),
        anchor: Anchor.center,
        position: gameRef.size / 2,
      ),
      TextComponent(
        text: 'Tap to return to Main Menu',
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 24,
            color: Color(0xFFFFFFFF),
          ),
        ),
        anchor: Anchor.center,
        position: Vector2(gameRef.size.x / 2, gameRef.size.y * 0.7),
      ),
    ]);
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    // Kembali ke menu utama
    // Ini memerlukan sedikit perubahan di main.dart, atau menggunakan deep linking
    // Untuk saat ini, kita restart game saja.
    gameRef.playerData.reset();
    gameRef.router.pushReplacementNamed('overworld');
    super.onTapUp(event);
  }
}
