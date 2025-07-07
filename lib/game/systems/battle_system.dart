// lib/systems/battle_system.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ruins_legacy/game/components/enemies/enemy.dart';
import 'package:ruins_legacy/models/game_data.dart';

// Enum untuk status pertarungan
enum BattleState { selectingAction, playerTurn, enemyTurn, battleWon, battleLost }

// Enum untuk aksi pemain
enum PlayerAction { fight, act, item, mercy }

// Sistem ini adalah otak dari semua logika pertarungan.
class BattleSystem {
  final GameData playerData;
  final Enemy enemy;
  final VoidCallback onBattleEnd; // Fungsi untuk dipanggil saat pertarungan selesai

  final StreamController<BattleState> _stateController = StreamController.broadcast();
  Stream<BattleState> get state => _stateController.stream;

  final StreamController<String> _dialogueController = StreamController.broadcast();
  Stream<String> get dialogue => _dialogueController.stream;

  BattleSystem({required this.playerData, required this.enemy, required this.onBattleEnd}) {
    _stateController.add(BattleState.selectingAction);
    _dialogueController.add('* ${enemy.name} appeared!');
  }

  void selectAction(PlayerAction action) {
    switch (action) {
      case PlayerAction.fight:
        _playerAttack();
        break;
      case PlayerAction.act:
        // TODO: Implementasi logika ACT (misalnya, check, talk)
        _dialogueController.add('* You tried to talk. It seems ineffective.');
        _startEnemyTurn();
        break;

      case PlayerAction.item:
        // TODO: Implementasi logika ITEM
        _dialogueController.add('* You have no items!');
        _startEnemyTurn();
        break;
      case PlayerAction.mercy:
        // TODO: Implementasi logika MERCY (spare, flee)
        _dialogueController.add('* You decided to flee.');
        _endBattle(true); // Asumsikan kabur berhasil
        break;
    }
  }

  void _playerAttack() {
    _stateController.add(BattleState.playerTurn);
    // TODO: Implementasi mini-game serangan di sini
    
    // Untuk sekarang, kita hit biasa
    final damage = playerData.attack;
    enemy.takeDamage(damage);
    _dialogueController.add('* You attacked! Dealt $damage damage.');

    if (enemy.isDefeated) {
      _endBattle(true);
    } else {
      _startEnemyTurn();
    }
  }

  void _startEnemyTurn() async {
    await Future.delayed(const Duration(seconds: 2));
    _stateController.add(BattleState.enemyTurn);
    _dialogueController.add('* ${enemy.name} is attacking!');
    
    // TODO: Implementasi mini-game bertahan (bullet hell) di sini.
    // PlayerHeart akan bergerak di sini.

    // Untuk sekarang, kita terima damage biasa
    await Future.delayed(const Duration(seconds: 2));
    final damage = enemy.attack - playerData.defense;
    playerData.currentHp -= damage > 0 ? damage : 0;
    _dialogueController.add('* You took $damage damage.');
    
    if (playerData.currentHp <= 0) {
      _endBattle(false);
    } else {
       _stateController.add(BattleState.selectingAction);
       _dialogueController.add('* What will you do?');
    }
  }

  void _endBattle(bool won) {
    if (won) {
      _stateController.add(BattleState.battleWon);
      _dialogueController.add('* YOU WON!');
    } else {
      _stateController.add(BattleState.battleLost);
      _dialogueController.add('* GAME OVER');
    }
    // Panggil callback setelah beberapa detik
    Future.delayed(const Duration(seconds: 3), onBattleEnd);
  }

  void dispose() {
    _stateController.close();
    _dialogueController.close();
  }
}