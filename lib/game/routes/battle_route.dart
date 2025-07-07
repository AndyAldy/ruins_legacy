// lib/game/routes/battle_route.dart

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:ruins_legacy/game/components/enemies/enemy.dart';
import 'package:ruins_legacy/game/enemies/enemy.dart';
import 'package:ruins_legacy/game/ruins.dart';
import 'package:ruins_legacy/game/systems/battle_system.dart';
import 'package:ruins_legacy/game/systems/battle_system.dart';
import 'package:ruins_legacy/widgets/battle_ui/battle_box.dart';

// Route ini sekarang mengelola seluruh scene pertarungan.
class BattleRoute extends Route {
  final Enemy Function() enemyBuilder;
  late BattleSystem _battleSystem;

  BattleRoute({required this.enemyBuilder}) : super(transparent: false);

  @override
  Component build() {
    return Component(); // Komponen kosong, karena UI ditangani oleh Flutter
  }

  @override
  void onPush(Route? previousRoute, dynamic game) {
    _battleSystem = BattleSystem(
      playerData: game.playerData,
      enemy: enemyBuilder(),
      onBattleEnd: game.endBattle,
    );

    // Tambahkan komponen Enemy ke dalam game tree
    final enemyComponent = _battleSystem.enemy;
    enemyComponent.position = Vector2(game.size.x / 2, game.size.y * 0.3);
    game.add(enemyComponent);

    // Tampilkan overlay UI pertarungan
    game.overlays.add('BattleUI');
  }

  @override
  void onPop(Route nextRoute) {
    // Hapus UI dan musuh saat pertarungan selesai
    game.overlays.remove('BattleUI');
    game.removeWhere((c) => c is Enemy);
    _battleSystem.dispose();
  }
  
  // Sediakan akses ke battle system untuk UI
  @override
  T? findProvider<T>() {
    if (T == BattleSystem) {
      return _battleSystem as T;
    }
    return null;
  }
}