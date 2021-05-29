import 'package:flutter/material.dart';

class ThemesData {
  String theme;
  Color backgroundColor1,
      backgroundColor2,
      buttonColor1,
      buttonColor2,
      textColor1,
      textColor2,
      textfieldColor,
      iconColor,
      scaffoldColor;

  ThemesData(this.theme) {
    bool isDarkMode = theme == 'Dark' ? true : false;
    backgroundColor1 = isDarkMode ? Colors.black : Color(0xffFAF7F2);
    scaffoldColor = isDarkMode ? Colors.white24 : Colors.white;
    iconColor = isDarkMode ? Colors.white : Colors.black;
    backgroundColor2 = isDarkMode ? Colors.black : Colors.white70;
    buttonColor1 = isDarkMode ? Colors.white : Colors.black;
    textfieldColor = isDarkMode ? Colors.white24 : Colors.grey.withOpacity(.2);
    buttonColor2 = Color(0xffF94701);
    textColor1 = isDarkMode ? Colors.white : Colors.black;
    textColor2 = isDarkMode ? Colors.black.withOpacity(.7) : Colors.white70;
  }
}
