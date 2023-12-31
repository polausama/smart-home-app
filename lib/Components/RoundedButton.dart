import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  VoidCallback? press;
  var color;
  var textColor = Colors.white;
  RoundedButton({
    this.text = 'LogIg',
    this.press,
    this.color,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: RoundedButton(
          press:press ,
textColor: textColor,
          color: color,
          text: text
        ),
      ),
    );
  }
}
