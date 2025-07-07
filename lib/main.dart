import 'package:flutter/material.dart';
import 'screens/game.dart'; // Import game screen yang baru kita buat

void main() {
  // runApp akan menjalankan aplikasi Flutter kita.
  // Kita arahkan langsung ke GameScreen.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameScreen(), // Atur GameScreen sebagai halaman utama
    );
  }
}