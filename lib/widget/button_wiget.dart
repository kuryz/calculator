import 'package:flutter/material.dart';
import 'package:Calc/colors.dart';

// creating Stateless Widget for buttons
class MyButton extends StatelessWidget {

// declaring variables
final color;
final textColor;
final bdrColor;
final String buttonText;
final buttontapped;

//Constructor
MyButton({this.color, this.bdrColor = false, this.textColor, this.buttonText, this.buttontapped});

@override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: Container(
        height: 30,
        width: 30,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), 
          color: color,
          border: Border.all(color: !bdrColor ? CalColors.colorButtonLight : CalColors.colorButton)),
        //color: color,
        child: Center(
        child: buttonText == '/' ? Image.asset('asset/division.png')
        : buttonText != 'r' ? Text(
          buttonText,
          style: TextStyle(
          color: textColor,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          ),
        ) : bdrColor ? Image.asset('asset/refresh_light.png') : Image.asset('asset/refresh_dark.png'),
        ),
      ),
    );
  }
}
