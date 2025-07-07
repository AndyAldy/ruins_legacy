import 'dart:async';
import 'package:ruins_legacy/game/components/enemies/enemy.dart';
import 'package:ruins_legacy/models/game_data.dart';

enum BattleState { selectingAction, playerTurn, enemyTurn, battleWon, battleLost }
enum PlayerAction { fight, act, item, mercy }

class BattleSystem {
  final GameData playerData;
  final Enemy enemy;
  final void Function({required bool battleWon}) onBattleEnd;

  final StreamController<BattleState> _stateController = StreamController.broadcast();
  Stream<BattleState> get state => _stateController.stream;

  final StreamController<String> _dialogueController = StreamController.broadcast();
  Stream<String> get dialogue => _dialogueController.stream;

  BattleSystem({required this.playerData, required this.enemy, required this.onBattleEnd}) {
    _stateController.add(BattleState.selectingAction);
    // PERBAIKAN: Ganti 'enemyName' menjadi 'name' agar sesuai dengan kelas Enemy
    _dialogueController.add('* ${enemy.name} appeared!');
  }

  void selectAction(PlayerAction action) {
    switch (action) {
      case PlayerAction.fight:
        _playerAttack();
        break;
      case PlayerAction.act:
        _dialogueController.add('* You tried to talk. It seems ineffective.');
        _startEnemyTurn();
        break;
      case PlayerAction.item:
        _dialogueController.add('* You have no items!');
        _startEnemyTurn();
        break;
      case PlayerAction.mercy:
        _dialogueController.add('* You decided to flee.');
        _endBattle(won: true); // Asumsikan kabur berhasil
        break;
    }
  }

  void _playerAttack() {
    _stateController.add(BattleState.playerTurn);
    final damage = playerData.attack;
    enemy.takeDamage(damage);
    _dialogueController.add('* You attacked! Dealt $damage damage.');

    if (enemy.isDefeated) {
      _endBattle(won: true);
    } else {
      _startEnemyTurn();
    }
  }

  void _startEnemyTurn() async {
    await Future.delayed(const Duration(seconds: 2));
    _stateController.add(BattleState.enemyTurn);
    // PERBAIKAN: Ganti 'enemyName' menjadi 'name'
    _dialogueController.add('* ${enemy.name} is attacking!');
    
    await Future.delayed(const Duration(seconds: 2));
    playerData.takeDamage(enemy.attack);
    _dialogueController.add('* You took damage!');
    
    if (playerData.currentHp <= 0) {
      _endBattle(won: false);
    } else {
      _stateController.add(BattleState.selectingAction);
      _dialogueController.add('* What will you do?');
    }
  }

  void _endBattle({required bool won}) {
    if (won) {
      _stateController.add(BattleState.battleWon);
      _dialogueController.add('* YOU WON!');
    } else {
      _stateController.add(BattleState.battleLost);
      _dialogueController.add('* GAME OVER');
    }
    Future.delayed(const Duration(seconds: 3), () => onBattleEnd(battleWon: won));
  }

  void dispose() {
    _stateController.close();
    _dialogueController.close();
  }
}
