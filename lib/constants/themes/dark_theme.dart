import 'package:flutter/material.dart';

final kDarkAppTheme = ThemeData.dark().copyWith(
  colorScheme: kDarkColorScheme,
  // appBarTheme: kAppBarTheme,
  cardTheme: kCardTheme,
  elevatedButtonTheme: kElevatedButtonTheme,
);

final kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

final kAppBarTheme = AppBarTheme().copyWith(
  backgroundColor: kDarkColorScheme.onPrimaryContainer,
  foregroundColor: kDarkColorScheme.primaryContainer,
);

final kCardTheme = CardTheme().copyWith(
  color: kDarkColorScheme.secondaryContainer,
  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
);

final kElevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: kDarkColorScheme.primaryContainer,
    foregroundColor: kDarkColorScheme.onPrimaryContainer,
  ),
);
