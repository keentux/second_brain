import 'package:flutter/material.dart';
import 'package:second_brain/themes/color.dart';

abstract class AppTheme {
  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Quicksand',
      // Colors App Theme
      colorScheme: const ColorScheme.dark().copyWith(
        primary: myPrimaryColor,
        onPrimary: myPrimaryColorLight,
        secondary: mySecondaryColor,
        onSecondary: mySecondaryColorLight,
        tertiary: myAccentColor,
        onTertiary: myAccentLightColor,
        outline: myWhiteColor,
        outlineVariant: myAccentNotifColor,
      ),
      // Dialog App Theme
      dialogTheme: DialogTheme(
        surfaceTintColor: Colors.transparent,
        backgroundColor: myPrimaryColor,
      ),
      // Navigation Rail Theme
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: Colors.transparent,
        useIndicator: false,
        selectedLabelTextStyle: TextStyle(
          color: myAccentColor,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelTextStyle: TextStyle(
          color: myAccentLightColor,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
