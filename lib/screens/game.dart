// lib/screens/game.dart

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ruins_legacy/game/ruins.dart';
import 'package:ruins_legacy/game/systems/battle_system.dart';
import 'package:ruins_legacy/widgets/battle_ui/battle_box.dart';

// Widget ini adalah host untuk FlameGame dan overlay-nya.
class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GameWidget<RuinsGame>.controlled(
      gameFactory: RuinsGame.new,
      overlayBuilderMap: {
        'BattleUI': (context, game) {
          // Cari BattleSystem dari provider di route
          final battleSystem = game.router.currentRoute.findProvider<BattleSystem>();
          if (battleSystem == null) return const SizedBox.shrink();
          
          return BattleBox(battleSystem: battleSystem);
        },
      },
    );
  }
}