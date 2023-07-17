import 'package:flutter/material.dart';
import 'package:rpgdiceroller/utilities/dialogs/roll_result_dialog.dart';
import 'package:rpgdiceroller/constants/dice_size.dart';
import 'package:rpgdiceroller/services/dice_roll_service.dart';
import 'package:rpgdiceroller/utilities/generic_icon_button.dart';

class DiceTab extends StatefulWidget {
  const DiceTab({super.key});

  @override
  State<DiceTab> createState() => _DiceTabState();
}

class _DiceTabState extends State<DiceTab> {
  late final DiceRollService _diceRollService;

  int _diceAmount = 1;
  int _modificator = 0;

  void _incrementModificator() => setState(() => _modificator++);
  void _decrementModificator() => setState(() => _modificator--);
  void _incrementDiceAmount() => setState(() => _diceAmount++);
  void _decrementDiceAmount() {
    if (_diceAmount > 1) {
      setState(() => _diceAmount--);
    }
  }

  @override
  void initState() {
    _diceRollService = DiceRollService();
    super.initState();
  }

  InkWell diceButton({required DiceSize diceSize}) {
    return InkWell(
      onTap: () {
        Roll roll = _diceRollService.roll(
          diceAmount: _diceAmount,
          diceSize: diceSize,
          modificator: _modificator,
        );
        showRollResultDialog(context: context, roll: roll);
      },
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: const BoxConstraints(
                maxHeight: 90,
                maxWidth: 90,
              ),
              child: Image.asset('lib/icons/${diceSize.name}.png'),
            ),
            Text(diceSize.name),
          ],
        ),
      ),
    );
  }

  // SizedBox bottomTextSizedBox({required String text}) {
  //   double width = 45;
  //   double height = 30;
  //   return SizedBox(
  //     height: height,
  //     width: width,
  //     child: Center(child: Text(text)),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: OrientationBuilder(
            builder: (context, orientation) {
              return GridView.count(
                crossAxisCount: orientation == Orientation.portrait ? 3 : 5,
                children: DiceSize.values
                    .map<InkWell>((diceSize) => diceButton(diceSize: diceSize))
                    .toList(),
              );
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.all(12.0),
          constraints: const BoxConstraints(maxHeight: 30),
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  GenericIconButton(
                    onPressed: _decrementDiceAmount,
                    icon: const Icon(Icons.remove),
                  ),
                  //bottomTextSizedBox(text: '${_diceAmount}d'),
                  Container(
                    height: 30,
                    padding: const EdgeInsets.only(top: 5),
                    child: DropdownButton<int>(
                      iconSize: 0,
                      underline: const SizedBox(),
                      alignment: Alignment.center,
                      value: _diceAmount,
                      items: List.generate(
                        100,
                        (index) => index + 1,
                      )
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text('${value}d', textScaleFactor: 1.3),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _diceAmount = value!;
                        });
                      },
                    ),
                  ),
                  GenericIconButton(
                    onPressed: _incrementDiceAmount,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Row(
                children: [
                  GenericIconButton(
                    onPressed: _decrementModificator,
                    icon: const Icon(Icons.remove),
                  ),
                  // Builder(builder: (context) {
                  //   String text;
                  //   if (_modificator < 0) {
                  //     text = '$_modificator';
                  //   } else {
                  //     text = '+$_modificator';
                  //   }
                  //   return bottomTextSizedBox(text: text);
                  // }),
                  Container(
                    height: 30,
                    padding: const EdgeInsets.only(top: 5),
                    child: DropdownButton<int>(
                      iconSize: 0,
                      underline: const SizedBox(),
                      alignment: Alignment.center,
                      value: _modificator,
                      items: List.generate(
                        100,
                        (index) => index - 49,
                      )
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(value < 0 ? '$value' : '+$value',
                                  textScaleFactor: 1.3),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _modificator = value!;
                        });
                      },
                    ),
                  ),
                  GenericIconButton(
                    onPressed: _incrementModificator,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
