nama_game_anda/
├── android/
├── ios/
├── ... (folder platform lainnya)
|
├── assets/
│   ├── audio/
│   │   ├── music/         # Untuk file musik latar (BGM)
│   │   └── sfx/           # Untuk sound effects (serangan, tombol, dll)
│   ├── images/
│   │   ├── sprites/       # Gambar karakter, musuh, item
│   │   │   ├── player/
│   │   │   ├── enemies/
│   │   │   └── items/
│   │   ├── tilesets/      # Gambar untuk membangun dunia/level
│   │   └── ui/            # Gambar untuk tombol, ikon, dll.
│   └── fonts/             # File font untuk dialog, menu, dll.
|
├── lib/
│   ├── main.dart          # Titik awal aplikasi Flutter
│   │
│   ├── **game**/              # Semua logika inti dari Flame Engine ada di sini
│   │   ├── underta_game.dart  # Class utama game Anda (extends FlameGame)
│   │   │
│   │   ├── **components**/    # Semua objek di dalam game (player, musuh, dll)
│   │   │   ├── player/
│   │   │   │   ├── player.dart         # Komponen untuk karakter utama di world map
│   │   │   │   └── player_heart.dart   # Komponen HATI saat di dalam battle box
│   │   │   ├── enemies/
│   │   │   │   ├── enemy.dart          # Base class untuk semua musuh
│   │   │   │   ├── keroco_a.dart
│   │   │   │   └── boss_sans.dart      # Contoh komponen untuk boss
│   │   │   └── world/
│   │   │       └── level_afterlife.dart # Komponen untuk peta/dunia game
│   │   │
│   │   ├── **systems**/       # Sistem yang mengatur mekanik game
│   │   │   ├── battle_system.dart    # Logika inti untuk battle (turn-based, dll)
│   │   │   └── dialogue_system.dart  # Logika untuk menampilkan dan mengelola dialog
│   │   │
│   │   └── **attacks**/       # Pola serangan musuh di dalam battle box
│   │       ├── base_attack.dart      # Base class untuk semua pola serangan
│   │       └── gaster_blaster.dart   # Contoh pola serangan spesifik
│   │
│   ├── **models**/             # Struktur data murni (bukan komponen visual)
│   │   ├── game_data.dart     # Untuk menyimpan & me-load progres game
│   │   └── dialogue_node.dart # Struktur untuk setiap percakapan
│   │
│   ├── **screens**/            # Halaman-halaman UI Flutter (di luar game engine)
│   │   ├── main_menu_screen.dart
│   │   ├── game_screen.dart     # Halaman yang menampung widget FlameGame
│   │   └── battle_screen.dart   # Halaman yang menampilkan UI battle (tombol, health bar)
│   │
│   └── **widgets**/             # Widget Flutter yang bisa digunakan kembali
│       ├── dialogue_box.dart    # Widget untuk kotak dialog percakapan
│       └── battle_ui/
│           ├── action_button.dart  # Tombol ATK, ACT, ITEM, MERCY
│           └── battle_box.dart     # Widget untuk kotak putih tempat HATI berada
|
└── pubspec.yaml
