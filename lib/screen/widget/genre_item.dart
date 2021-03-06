import 'package:flutter/material.dart';

class GenreItem extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final bool shadow;
  final double fontSize;

  GenreItem(
      {@required this.text,
      @required this.textColor,
      @required this.backgroundColor,
      this.shadow = false,
      this.fontSize = 13});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text),
      labelStyle: TextStyle(color: textColor, fontSize: fontSize),
      backgroundColor: backgroundColor,
      shadowColor: backgroundColor,
      elevation: shadow == false ? 0 : 4.0,
    );
  }
}
