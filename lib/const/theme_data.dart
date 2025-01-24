import 'package:flutter/material.dart';

final ThemeData theme = ThemeData();

/// ----  Pink Theme  ----
const pinkAccentPrimary = Color(0xFFDF0AFC);
const voiletPrimary = Color(0xFF5611F8);
const pinkAccent = Color(0xFF5611F8);
const pinkBackground = Color(0xFFF7F7F7);
final pinkTheme = ThemeData(
    fontFamily: "Roboto",
    primaryColor: voiletPrimary,
    primaryColorLight: pinkAccentPrimary,
    colorScheme: theme.colorScheme.copyWith(
      secondary: pinkAccent,
      primary: voiletPrimary,
    ),
    scaffoldBackgroundColor: pinkBackground,
    disabledColor: Colors.grey,
    textSelectionTheme: const TextSelectionThemeData(
        cursorColor: voiletPrimary,
        selectionColor: voiletPrimary,
        selectionHandleColor: voiletPrimary),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: voiletPrimary),
    ));

/// ----  Green Theme  ----
const greenPrimary = Color(0xFF4CAF50);
const secondaryGreenPrimary = Color(0xFF1D976C);
const greenAccent = Color(0xFF4CAF50);
const greenBackground = Color(0xFFF7F7F7);
final greenTheme = ThemeData(
  disabledColor: Colors.grey,
  fontFamily: "Roboto",
  primaryColor: greenPrimary,
  primaryColorLight: secondaryGreenPrimary,
  colorScheme: theme.colorScheme.copyWith(
    secondary: greenAccent,
    primary: greenPrimary,
  ),
  scaffoldBackgroundColor: greenBackground,
);

/// ----  Blue Theme  ----
const bluePrimary = Color(0xFF25308F);
const blueSecondary = Color(0xFF5066EB);
const blueAccent = Color(0xFF25308F);
const blueBackground = Color(0xFFF7F7F7);
final blueTheme = ThemeData(
  fontFamily: "Roboto",
  primaryColor: bluePrimary,
  primaryColorLight: blueSecondary,
  colorScheme: theme.colorScheme.copyWith(
    secondary: blueAccent,
    primary: bluePrimary,
  ),
  scaffoldBackgroundColor: blueBackground,
  disabledColor: Colors.grey,
);

/// ----  Grey Theme  ----
const greyPrimary = Color(0xFF1F1C2C);
const greySecondary = Color(0xFF928DAB);
const greyAccent = Color(0xFF1F1C2C);
const greyBackground = Color(0xFFF7F7F7);
final greyTheme = ThemeData(
  fontFamily: "Roboto",
  primaryColor: greyPrimary,
  primaryColorLight: greySecondary,
  colorScheme: theme.colorScheme.copyWith(
    secondary: greyAccent,
    primary: greyPrimary,
  ),
  scaffoldBackgroundColor: greyBackground,
  disabledColor: Colors.grey,
);

/// ----  Light Blue Theme  ----
const lightBluePrimary = Color(0xFF1A2980);
const lightBlueSecondary = Color(0xFF26D0CE);
const lightBlueAccent = Color(0xFF1A2980);
const lightBlueBackground = Color(0xFFF7F7F7);
final lightBlueTheme = ThemeData(
  fontFamily: "Roboto",
  disabledColor: Colors.grey,
  primaryColor: lightBluePrimary,
  primaryColorLight: lightBlueSecondary,
  colorScheme: theme.colorScheme.copyWith(
    secondary: lightBlueAccent,
    primary: lightBluePrimary,
  ),
  scaffoldBackgroundColor: lightBlueBackground,
);

/// ----  Dark Pink Theme  ----
const darkPinkPrimary = Color(0xFFAA076B);
const darkPinkSecondary = Color(0xFF61045F);
const darkPinkAccent = Color(0xFFAA076B);
const darkPinkAccent2 = Color.fromARGB(255, 231, 180, 211);
const darkPinkBackground = Color(0xFFF7F7F7);
final darkPinkTheme = ThemeData(
  fontFamily: "Roboto",
  disabledColor: Colors.grey,
  primaryColor: darkPinkPrimary,
  primaryColorLight: darkPinkSecondary,
  colorScheme: theme.colorScheme.copyWith(
    secondary: darkPinkAccent,
    primary: darkPinkPrimary,
  ),
  scaffoldBackgroundColor: darkPinkBackground,
);

/// ----  Orange Theme  ----
const orangePrimary = Color(0xFFAA076A);
const orangeSecondary = Color(0xFFF09819);
const orangeAccent = Color(0xFFAA076A);
const orangeBackground = Color(0xFFF7F7F7);
final orangeTheme = ThemeData(
  fontFamily: "Roboto",
  disabledColor: Colors.grey,
  primaryColor: orangePrimary,
  primaryColorLight: orangeSecondary,
  colorScheme: theme.colorScheme.copyWith(
    secondary: orangeAccent,
    primary: orangePrimary,
  ),
  scaffoldBackgroundColor: orangeBackground,
);

/// ----  Burgandy Theme  ----
const burgandyPrimary = Color(0xFFF21E0A);
const burgandySecondary = Color(0xFF6D0D04);
const burgandyAccent = Color(0xFFF21E0A);
const burgandyBackground = Color(0xFFF7F7F7);
final burgandyTheme = ThemeData(
  fontFamily: "Roboto",
  disabledColor: Colors.grey,
  primaryColor: burgandyPrimary,
  primaryColorLight: burgandySecondary,
  colorScheme: theme.colorScheme.copyWith(
    secondary: burgandyAccent,
    primary: burgandyPrimary,
  ),
  scaffoldBackgroundColor: burgandyBackground,
);
