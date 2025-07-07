// lib/game/components/battle/battle_screen.dart
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';
import 'package:ruins_legacy/game/ruins.dart';

class BattleScreen extends Component with HasGameRef<RuinsGame> {
  @override
  Future<void> onLoad() async {
    // Latar belakang hitam untuk mode pertarungan
    add(
      RectangleComponent.fromRect(
        game.camera.visibleWorldRect,
        paint: BasicPalette.black.paint(),
      ),
    );

    // Placeholder untuk UI pertarungan
    add(
      TextComponent(
        text: '--- BATTLE START ---',
        position: game.size / 2,
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: TextStyle(
            color: BasicPalette.white.color,
            fontSize: 48,
          ),
        ),
      ),
    );
  }

  // Kita akan menambahkan logika untuk kembali ke overworld di sini nanti
  void endBattle() {
    game.endBattle();
  }
}