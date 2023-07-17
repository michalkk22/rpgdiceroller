import 'package:flutter/material.dart';
import 'package:rpgdiceroller/tabs/dice_tab.dart';
import 'package:rpgdiceroller/tabs/history_tab.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'RPG Dice Roller',
      theme: ThemeData.dark(),
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('RPG Dice Roller'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Dice'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DiceTab(),
            HistoryTab(),
          ],
        ),
      ),
    );
  }
}
