// lib/models/dialogue_node.dart

import 'package:flutter/foundation.dart';

// Kelas untuk merepresentasikan satu bagian dari percakapan.
// Bisa diperluas untuk dialog bercabang.
@immutable
class DialogueNode {
  final String text;
  final List<DialogueOption>? options;

  const DialogueNode({required this.text, this.options});
}

@immutable
class DialogueOption {
  final String text;
  final VoidCallback onSelected; // Fungsi yang dipanggil saat opsi dipilih

  const DialogueOption({required this.text, required this.onSelected});
}