import 'package:flutter/material.dart';

final kLightTheme = ThemeData.light().copyWith(
  colorScheme: kColorScheme,
  appBarTheme: kAppBarTheme,
  cardTheme: kCardTheme,
  elevatedButtonTheme: kElevatedButtonTheme,
  textTheme: kTextTheme,
);

final kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

final kAppBarTheme = AppBarTheme().copyWith(
  backgroundColor: kColorScheme.onPrimaryContainer,
  foregroundColor: kColorScheme.primaryContainer,
);

final kCardTheme = CardTheme().copyWith(
  color: kColorScheme.secondaryContainer,
  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
);

final kElevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: kColorScheme.primaryContainer,
  ),
);

final kTextTheme = ThemeData.light().textTheme.copyWith(
  titleLarge: TextStyle(
    fontWeight: FontWeight.bold,
    color: kColorScheme.onSecondaryContainer,
    fontSize: 16,
  ),
);
