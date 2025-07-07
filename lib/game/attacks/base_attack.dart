import 'package:flame/components.dart';

// Kelas dasar untuk semua pola serangan musuh di fase bertahan.
abstract class BaseAttack extends Component {
  // Anda bisa menambahkan properti umum di sini,
  // seperti durasi serangan, referensi ke player, dll.

  // Method untuk memulai serangan
  void start();

  // Method untuk menghentikan/membersihkan serangan
  void stop();

  // Properti untuk memeriksa apakah serangan sudah selesai
  bool get isFinished;
}
