import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData icon;

  const ActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.icon,
    // Hapus 'required Text child' yang tidak perlu
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.yellow, size: 18),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white, width: 2),
          shape: const BeveledRectangleBorder(),
          textStyle: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
