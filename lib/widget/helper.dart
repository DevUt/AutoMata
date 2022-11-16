import 'package:flutter/material.dart';

Widget amberText(String enterText) {
  return Text(style: const TextStyle(color: Colors.amber), enterText);
}

Widget leadingIcon() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Icon(Icons.dehaze_rounded),
    ],
  );
}
