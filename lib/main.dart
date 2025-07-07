// lib/main.dart

import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:ruins_legacy/screens/main_menu.dart';

void main() async {
  // Pastikan Flame & Flutter sudah siap
  WidgetsFlutterBinding.ensureInitialized();
  // Set ke mode landscape
  await Flame.device.setLandscape();
  // Set ke mode fullscreen
  await Flame.device.fullScreen();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ruins Legacy',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const MainMenuScreen(), // Mulai dari Main Menu
    );
  }
}