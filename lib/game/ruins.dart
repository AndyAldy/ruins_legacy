import 'dart:async';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';

// Ini adalah class utama game Anda. Semua logika inti game akan berada di sini.
// FlameGame adalah class dasar dari Flame Engine yang menyediakan game loop,
// sistem komponen, dan semua yang kita butuhkan.
class RuinsGame extends FlameGame {
  
  // Method `onLoad` dipanggil sekali saat game pertama kali dimuat.
  // Ini adalah tempat yang sempurna untuk melakukan inisialisasi awal.
  @override
  Future<void> onLoad() async {
    // Untuk saat ini, kita hanya akan mengatur warna latar belakang
    // menjadi hitam, sesuai dengan tema battle Undertale.
    camera.viewfinder.backgroundColor = const Color(0xFF000000); // Warna hitam
  }
}