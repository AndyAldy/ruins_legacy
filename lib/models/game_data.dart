// lib/models/game_data.dart

// Kelas untuk menyimpan data progres pemain yang bisa disimpan (save) atau dimuat (load).
class GameData {
  int level;
  int maxHp;
  int currentHp;
  int attack;
  int defense;
  List<String> inventory;
  // Tambahkan flag untuk event cerita di sini
  // contoh: Set<String> storyFlags;

  GameData({
    this.level = 1,
    this.maxHp = 20,
    this.currentHp = 20,
    this.attack = 5,
    this.defense = 1,
    this.inventory = const [],
  });

  void reset() {
    level = 1;
    maxHp = 20;
    currentHp = 20;
    attack = 5;
    defense = 1;
    inventory = [];
  }
}