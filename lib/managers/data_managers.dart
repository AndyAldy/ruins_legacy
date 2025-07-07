import 'dart:convert';
import 'package:flame/cache.dart';
import 'package:ruins_legacy/game/components/enemies/boss1.dart';
import 'package:ruins_legacy/game/components/enemies/enemy.dart';
import 'package:ruins_legacy/game/components/enemies/keroco.dart';

// Kelas untuk menampung data musuh yang sudah diparsing
class EnemyData {
  final String id;
  final String name;
  final String sprite;
  final int maxHp;
  final int attack;
  final int defense;

  EnemyData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        sprite = json['sprite'],
        maxHp = json['maxHp'],
        attack = json['attack'],
        defense = json['defense'];
}

// Kelas untuk menampung data NPC yang sudah diparsing
class NpcData {
  final String mapName;
  final String sprite;
  final String dialogue;
  final bool isEnemy;
  final String? enemyId;

  NpcData.fromJson(Map<String, dynamic> json)
      : mapName = json['mapName'],
        sprite = json['sprite'],
        dialogue = json['dialogue'],
        isEnemy = json['isEnemy'],
        enemyId = json['enemyId'];
}

class DataManager {
  final Map<String, EnemyData> _enemies = {};
  final Map<String, NpcData> _npcs = {};

  NpcData? getNpcByMapName(String name) => _npcs[name];
  EnemyData? getEnemyById(String id) => _enemies[id];

  Future<void> load(AssetsCache assets) async {
    final enemyJsonString = await assets.read('data/enemies.json');
    final List<dynamic> enemyJsonList = json.decode(enemyJsonString);
    for (var jsonData in enemyJsonList) {
      final data = EnemyData.fromJson(jsonData);
      _enemies[data.id] = data;
    }

    final npcJsonString = await assets.read('data/npcs.json');
    final List<dynamic> npcJsonList = json.decode(npcJsonString);
    for (var jsonData in npcJsonList) {
      final data = NpcData.fromJson(jsonData);
      _npcs[data.mapName] = data;
    }
  }

  Enemy createEnemyById(String id) {
    final data = getEnemyById(id);
    if (data == null) {
      throw Exception('Enemy with id $id not found!');
    }
    
    switch (id) {
      case 'keroco':
        return Keroco(data: data);
      case 'golem':
        return Boss1(data: data);
      default:
        throw Exception('No enemy class mapping for id $id');
    }
  }
}
