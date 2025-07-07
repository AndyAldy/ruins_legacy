// lib/game/components/dialogue_box.dart
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';
import 'package:ruins_legacy/game/ruins.dart';

class DialogueBox extends TextBoxComponent {
  DialogueBox({required String text, required Vector2 gameSize})
      : super(
          text: text,
          position: Vector2(50, gameSize.y - 150), // Posisi di bagian bawah layar
          boxConfig: TextBoxConfig(
            maxWidth: gameSize.x - 100,
            timePerChar: 0.05, // Kecepatan teks muncul
            growingBox: true,
            margins: const EdgeInsets.all(20),
          ),
        ) {
    // Styling untuk kotak dialog
    final paint = BasicPalette.black.withAlpha(200).paint();
    final borderPaint = BasicPalette.white.paint()..strokeWidth = 2;
    boxConfig.decorator = RRectComponent(
        paint: paint,
        borderPaint: borderPaint,
        radius: const Radius.circular(8)
    );
    // Styling untuk teks
    textRenderer = TextPaint(
      style: TextStyle(
        fontSize: 24,
        color: BasicPalette.white.color,
        fontFamily: 'Arial', // Anda bisa ganti dengan font pixel
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (finished) {
      // Hapus dialog box setelah selesai dan user menekan tombol
      // Logika ini akan kita tambahkan di input handler game utama
    }
  }
}