import 'package:flutter/material.dart';

class GenericIconButton extends StatelessWidget {
  final void Function() onPressed;
  final Icon icon;

  const GenericIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(3),
      iconSize: 30,
      //color: Colors.blueGrey,
      //disabledColor: Colors.black,
      onPressed: onPressed,
      icon: icon,
    );
  }
}
