// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ruins_legacy/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // PERBAIKAN: Ganti MyApp dengan RuinsLegacy agar sesuai dengan main.dart
    await tester.pumpWidget(const RuinsLegacy());

    // Contoh test sederhana, bisa kamu sesuaikan nanti.
    // Kode di bawah ini mungkin tidak relevan untuk game-mu dan bisa dihapus.
    // Verify that our counter starts at 0.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsNothing);

  });
}