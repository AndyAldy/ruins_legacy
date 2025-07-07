// lib/widgets/battle_ui/battle_box.dart

import 'package:flutter/material.dart';
import 'package:ruins_legacy/game/systems/battle_system.dart';
import 'package:ruins_legacy/game/systems/battle_system.dart';
import 'package:ruins_legacy/widgets/battle_ui/action_button.dart';

class BattleBox extends StatefulWidget {
  final BattleSystem battleSystem;
  const BattleBox({Key? key, required this.battleSystem}) : super(key: key);

  @override
  State<BattleBox> createState() => _BattleBoxState();
}

class _BattleBoxState extends State<BattleBox> {
  String _dialogueText = '';

  @override
  void initState() {
    super.initState();
    widget.battleSystem.dialogue.listen((text) {
      if (mounted) {
        setState(() {
          _dialogueText = text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(4),
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          color: Colors.black,
        ),
        child: Row(
          children: [
            // Kotak dialog/narasi
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  _dialogueText,
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Courier'),
                ),
              ),
            ),
            // Kotak aksi
            Expanded(
              flex: 2,
              child: StreamBuilder<BattleState>(
                stream: widget.battleSystem.state,
                initialData: BattleState.selectingAction,
                builder: (context, snapshot) {
                  if (snapshot.data != BattleState.selectingAction) {
                    return const SizedBox.shrink(); // Sembunyikan tombol jika bukan giliran pemain
                  }
                  return GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    children: [
                      ActionButton(label: 'FIGHT', icon: Icons.flash_on, onPressed: () => widget.battleSystem.selectAction(PlayerAction.fight)),
                      ActionButton(label: 'ACT', icon: Icons.mood, onPressed: () => widget.battleSystem.selectAction(PlayerAction.act)),
                      ActionButton(label: 'ITEM', icon: Icons.work, onPressed: () => widget.battleSystem.selectAction(PlayerAction.item)),
                      ActionButton(label: 'MERCY', icon: Icons.favorite, onPressed: () => widget.battleSystem.selectAction(PlayerAction.mercy)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}