import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:ruins_legacy/game/ruins.dart';

class BattleRoute extends Route {
  BattleRoute() : super(BattleScreen.new, transparent: true);

  // Anda bisa passing data ke battle screen di sini jika perlu
}

class BattleScreen extends Component with HasGameRef<RuinsGame> {
  @override
  Future<void> onLoad() async {
    // Latar belakang hitam
    add(
      RectangleComponent.fromRect(
        game.camera.visibleWorldRect,
        paint: BasicPalette.black.paint(),
      ),
    );

    add(
      TextComponent(
        text: '--- BATTLE START ---\n(Tekan Q untuk kabur)',
        position: game.size / 2,
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: TextStyle(color: BasicPalette.white.color, fontSize: 32),
        ),
      ),
    );
  }

  // Logika untuk kembali ke overworld
  void endBattle() {
    game.router.pushNamed('overworld');
  }
}