import 'package:flame/components.dart';
import 'package:ruins_legacy/game/components/enemies/enemy.dart';
import 'package:ruins_legacy/game/ruins.dart';
import 'package:ruins_legacy/game/systems/battle_system.dart';

// Route ini sekarang mengelola seluruh scene pertarungan.
class BattleRoute extends Route {
  final Enemy Function() enemyBuilder;
  late BattleSystem _battleSystem;

  BattleSystem get battleSystem => _battleSystem;

  BattleRoute({required this.enemyBuilder}) : super();

  @override
  void onPush(Route? previousRoute) {
    final game = findGame<RuinsGame>();
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
    final game = findGame<RuinsGame>();
    game.overlays.remove('BattleUI');
    game.removeWhere((c) => c is Enemy);
    _battleSystem.dispose();
  }
}