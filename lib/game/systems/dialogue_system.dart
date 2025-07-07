// lib/systems/dialogue_system.dart

import 'package:ruins_legacy/game/ruins.dart';
import 'package:ruins_legacy/models/dialogue_node.dart';
import 'package:ruins_legacy/widgets/dialogue_box.dart';

// Sistem ini mengelola alur percakapan dalam game.
class DialogueSystem {
  final RuinsGame game;
  bool _isDialogueVisible = false;

  DialogueSystem(this.game);

  void showDialogue(DialogueNode node) {
    if (_isDialogueVisible) return;

    // Untuk saat ini kita hanya menampilkan teks.
    // Di masa depan, ini bisa diperluas untuk menangani 'node.options'.
    game.camera.viewport.add(DialogueBox(
      text: node.text,
      onComplete: hideDialogue, // Panggil hideDialogue saat teks selesai
      gameSize: game.size,
    ));
    _isDialogueVisible = true;
    game.player.canMove = false; // Player tidak bisa bergerak saat dialog
  }

  void hideDialogue() {
    game.camera.viewport.removeWhere((c) => c is DialogueBox);
    _isDialogueVisible = false;
    game.player.canMove = true; // Player bisa bergerak lagi
  }

  bool get isDialogueVisible => _isDialogueVisible;
}