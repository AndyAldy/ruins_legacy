import 'package:flutter/material.dart';
import 'package:ruins_legacy/game/systems/battle_system.dart';
import 'package:ruins_legacy/widgets/battle_ui/action_button.dart';

class BattleBox extends StatefulWidget {
  final BattleSystem battleSystem;
  const BattleBox({super.key, required this.battleSystem});

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
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  _dialogueText,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Courier'), // Ganti dengan font dari assets nanti
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: StreamBuilder<BattleState>(
                stream: widget.battleSystem.state,
                initialData: BattleState.selectingAction,
                builder: (context, snapshot) {
                  if (snapshot.data != BattleState.selectingAction) {
                    return const SizedBox.shrink();
                  }
                  return GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    children: [
                      ActionButton(
                          onPressed: () => widget.battleSystem.selectAction(PlayerAction.fight),
                          icon: Icons.flash_on,
                          label: 'FIGHT'), // Gunakan 'label'
                      ActionButton(
                          onPressed: () => widget.battleSystem.selectAction(PlayerAction.act),
                          icon: Icons.mood,
                          label: 'ACT'), // Gunakan 'label'
                      ActionButton(
                          onPressed: () => widget.battleSystem.selectAction(PlayerAction.item),
                          icon: Icons.work,
                          label: 'ITEM'), // Gunakan 'label'
                      ActionButton(
                          onPressed: () => widget.battleSystem.selectAction(PlayerAction.mercy),
                          icon: Icons.favorite,
                          label: 'MERCY'), // Gunakan 'label'
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
