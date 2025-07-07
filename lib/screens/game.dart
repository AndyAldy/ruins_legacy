import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../game/ruins.dart'; // Import file game utama Anda

// Ini adalah widget Flutter biasa yang akan menjadi "wadah" untuk game kita.
class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // GameWidget adalah jembatan antara UI Flutter dan game engine Flame.
      // Ia akan mengambil alih seluruh layar dan menjalankan game yang kita berikan.
      body: GameWidget(
        game: RuinsGame(), // Membuat dan menjalankan instance dari game Anda
      ),
    );
  }
}