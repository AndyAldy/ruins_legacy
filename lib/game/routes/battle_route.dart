import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:ruins_legacy/game/components/enemies/enemy.dart';
import 'package:ruins_legacy/game/ruins.dart';
import 'package:ruins_legacy/game/systems/battle_system.dart';

// Route ini sekarang mengelola seluruh scene pertarungan.
// PERBAIKAN: Tambahkan mixin 'HasGameRef<RuinsGame>'
class BattleRoute extends Route with HasGameRef<RuinsGame> {
  final Enemy Function() enemyBuilder;
  late BattleSystem _battleSystem;

  // Getter publik agar UI bisa mengakses battle system dengan aman
  BattleSystem get battleSystem => _battleSystem;

  BattleRoute({required this.enemyBuilder}) : super(Component.new);

  @override
  void onPush(Route? previousRoute) {
    // PERBAIKAN: Gunakan 'gameRef' yang disediakan oleh HasGameRef.
    // Ini lebih modern dan aman daripada findGame().
    final game = gameRef;
    _battleSystem = BattleSystem(
      playerData: game.playerData,
      enemy: enemyBuilder(),
      onBattleEnd: game.endBattle,
    );

    final enemyComponent = _battleSystem.enemy;
    enemyComponent.position = Vector2(game.size.x / 2, game.size.y * 0.3);
    game.add(enemyComponent);

    game.overlays.add('BattleUI');
  }

  @override
  void onPop(Route nextRoute) {
    // PERBAIKAN: Gunakan 'gameRef' juga di sini.
    final game = gameRef;
    game.overlays.remove('BattleUI');
    game.removeWhere((c) => c is Enemy);
    _battleSystem.dispose();
  }
}
