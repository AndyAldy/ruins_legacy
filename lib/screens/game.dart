import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ruins_legacy/game/routes/battle_route.dart';
import 'package:ruins_legacy/game/ruins.dart';
import 'package:ruins_legacy/widgets/battle_ui/battle_box.dart';

// Widget ini adalah host untuk FlameGame dan overlay-nya.
class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget<RuinsGame>.controlled(
      gameFactory: RuinsGame.new,
      overlayBuilderMap: {
        'BattleUI': (context, game) {
          // Ambil route yang sedang aktif
          final currentRoute = game.router.currentRoute;

          // PERBAIKAN: Periksa apakah route tersebut adalah BattleRoute
          if (currentRoute is BattleRoute) {
            // Jika ya, kita bisa dengan aman mengakses getter 'battleSystem'.
            // Tidak perlu lagi findProvider atau method lainnya.
            return BattleBox(battleSystem: currentRoute.battleSystem);
          }
          
          // Jika bukan BattleRoute, jangan tampilkan apa-apa
          return const SizedBox.shrink();
        },
      },
    );
  }
}
