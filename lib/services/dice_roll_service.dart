import 'dart:math';
import 'package:rpgdiceroller/constants/dice_size.dart';

class DiceRollService {
  DiceRollService._sharedInstance();
  static final DiceRollService _shared = DiceRollService._sharedInstance();
  factory DiceRollService() => _shared;

  final List<Roll> history = [];

  Roll roll({
    required int diceAmount,
    required DiceSize diceSize,
    required int modificator,
  }) {
    Roll roll = Roll(
      diceAmount: diceAmount,
      diceSize: diceSize,
      modificator: modificator,
    );
    history.add(roll);
    return roll;
  }

  void clearHistory() => history.clear();

  void deleteFromHistory(int index) => history.removeAt(index);
}

class Roll {
  final int diceAmount;
  final DiceSize diceSize;
  final int modificator;
  final List<int> rolls;
  final int rollResult;

  Roll._({
    required this.diceAmount,
    required this.diceSize,
    required this.modificator,
    required this.rolls,
    required this.rollResult,
  });

  factory Roll({
    required int diceAmount,
    required DiceSize diceSize,
    required int modificator,
  }) {
    int maxRand;
    maxRand = diceSizes[diceSize.name]!;
    int roll;
    List<int> rolls = [];
    int rollResult = modificator;
    for (var i = 0; i < diceAmount; i++) {
      roll = Random().nextInt(maxRand) + 1;
      rolls.add(roll);
      rollResult += roll;
    }
    return Roll._(
      diceAmount: diceAmount,
      diceSize: diceSize,
      modificator: modificator,
      rolls: rolls,
      rollResult: rollResult,
    );
  }

  String rollString() {
    String addMod = '';
    if (modificator > 0) {
      addMod = '+$modificator';
    } else if (modificator < 0) {
      addMod = '$modificator';
    }
    return '$diceAmount${diceSize.name}$addMod';
  }
}
