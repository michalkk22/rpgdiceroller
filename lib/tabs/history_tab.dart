import 'package:flutter/material.dart';
import 'package:rpgdiceroller/utilities/dialogs/confirm_dialog.dart';
import 'package:rpgdiceroller/utilities/dialogs/roll_result_dialog.dart';
import 'package:rpgdiceroller/services/dice_roll_service.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  late final DiceRollService _diceRollService;
  //final void Function(FloatingActionButton) changeFloatingActionButton;

  @override
  void initState() {
    _diceRollService = DiceRollService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _diceRollService.history.length,
        itemBuilder: (context, index) {
          final roll = _diceRollService.history[index];
          String title = roll.rollString();

          return ListTile(
            title: Text(title),
            subtitle: Text(roll.rolls.toString()),
            leading: Container(
              alignment: Alignment.center,
              width: 40,
              height: 40,
              color: Colors.grey[300],
              child: Text('${roll.rollResult}', textScaleFactor: 2),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                bool shouldDelete = await showConfirmDialog(
                  context: context,
                  title: 'Delete',
                  message: 'Are you sure want to delete this roll?',
                );
                if (shouldDelete) {
                  _diceRollService.deleteFromHistory(index);
                  setState(() {});
                }
              },
            ),
            onTap: () => showRollResultDialog(context: context, roll: roll),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool shouldDelete = await showConfirmDialog(
            context: context,
            title: 'Delete history',
            message: 'Are you sure want to delete history?',
          );
          if (shouldDelete) {
            _diceRollService.clearHistory();
            setState(() {});
          }
        },
        child: const Icon(Icons.delete_forever),
      ),
    );
  }
}
