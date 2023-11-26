import 'package:flutter/material.dart';

import '../../Components/Constants.dart';

Widget myContainer(
    {required Widget myChild, Color backGround = Colors.white}) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: backGround,
      ),
      child: myChild,
    ),
  );
}
