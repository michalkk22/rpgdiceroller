import 'package:flutter/material.dart';
import 'package:rpgdiceroller/services/dice_roll_service.dart';

Future<void> showRollResultDialog({
  required BuildContext context,
  required Roll roll,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(roll.rollString()),
            const SizedBox(height: 10),
            Text(
              '${roll.rollResult}',
              textScaleFactor: 2.5,
            ),
            const SizedBox(height: 10),
            Text(roll.rolls.toString()),
          ],
        ),
      );
    },
  );
}
