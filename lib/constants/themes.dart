import "package:flutter/material.dart";
import "package:todo_app/constants/colors.dart";

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: tBgColor,
    primary: Colors.white,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Colors.black,
    primary: Colors.blueGrey,
  ),
);