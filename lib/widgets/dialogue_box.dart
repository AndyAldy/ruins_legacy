import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';

class DialogueBox extends TextBoxComponent {
  DialogueBox({required String text})
      : super(
          text: text,
          // Pindahkan posisi dan anchor ke sini agar lebih rapi
          position: Vector2(0, 0), // Posisi akan diatur ulang di onGameResize
          anchor: Anchor.topCenter,
          boxConfig: TextBoxConfig(
            maxWidth: 500,
            timePerChar: 0.05,
            growingBox: true,
            margins: const EdgeInsets.all(25),
          ),
        ) {
    // Styling untuk teks
    textRenderer = TextPaint(
      style: TextStyle(
        fontSize: 22,
        color: BasicPalette.white.color,
        fontFamily: 'Arial', // Ganti dengan font custom jika ada
      ),
    );

    // Hapus semua logika decorator lama dari sini
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Cara modern untuk menambahkan background dan border
    // Kita tambahkan RectangleComponent sebagai child dari TextBoxComponent
    add(
      RectangleComponent(
        size: size, // Ukuran akan mengikuti ukuran TextBoxComponent
        paint: BasicPalette.black.withAlpha(220).paint(),
        children: [
          // Tambahkan border sebagai child dari background
          RectangleComponent(
            size: size,
            paint: BasicPalette.white.paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2,
          ),
        ],
      ),
    );
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    // Atur posisi di bagian bawah tengah layar setelah ukurannya diketahui
    position = Vector2(gameSize.x / 2, gameSize.y - height - 20);
  }
}
