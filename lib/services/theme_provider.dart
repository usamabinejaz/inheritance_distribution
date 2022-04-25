import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:inheritance_distribution/app_reserved/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  SharedPreferences? mSharedPrefs;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider({required bool darkThemeOn}) {
    _themeMode = darkThemeOn ? ThemeMode.dark : ThemeMode.light;
  }

  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance?.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return _themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool darkThemeOn) async {
    mSharedPrefs = await SharedPreferences.getInstance();
    _themeMode = darkThemeOn ? ThemeMode.dark : ThemeMode.light;
    mSharedPrefs!.setBool(Constants.darkModeString, darkThemeOn);
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData.dark().copyWith(
    highlightColor: Constants.appPrimaryColorLight,
    primaryColor: Constants.appPrimaryColorLight,
    scaffoldBackgroundColor: Constants.appBackgroundDark,
    shadowColor: Constants.appShadowColorDark,
    toggleableActiveColor: Constants.appPrimaryColorLight,
    backgroundColor: Constants.appBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: Constants.appGrey,
      foregroundColor: Constants.appBackground,
    ),
    colorScheme: const ColorScheme.dark().copyWith(
      secondary: Constants.appPrimaryColor,
      primary: Constants.appPrimaryColorLight,
      onPrimary: Constants.appBackgroundDark,
      onSurface: Constants.appBackground,
      tertiary: Constants.appGrey,
    ),
    iconTheme: const IconThemeData(
      color: Constants.appBackground,
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: const TextStyle(
        color: Constants.appPrimaryColorLight,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(
          style: BorderStyle.solid,
          color: Constants.appBackground,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          style: BorderStyle.solid,
          color: Constants.appPrimaryColorLight,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(
          Constants.appPrimaryColorLight,
        ),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Constants.appPrimaryColor,
      selectionColor: Constants.appBackground.withOpacity(0.2),
      selectionHandleColor: Constants.appBackground,
    ),
    textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Poppins',
        ),
    primaryTextTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Poppins',
        ),
  );
  static final lightTheme = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light(
      primary: Constants.appPrimaryColor,
      secondary: Constants.appPrimaryColorLight,
    ),
    primaryColor: Constants.appPrimaryColor,
    highlightColor: Constants.appBackground,
    backgroundColor: Constants.appGrey,
    scaffoldBackgroundColor: Constants.appBackground,
    shadowColor: Constants.appShadowColor,
    toggleableActiveColor: Constants.appPrimaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Constants.appPrimaryColor,
    ),
    iconTheme: const IconThemeData(
      color: Constants.appPrimaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: const TextStyle(
          color: Constants.appPrimaryColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            style: BorderStyle.solid,
            color: Constants.appBackgroundDark,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            style: BorderStyle.solid,
            color: Constants.appPrimaryColor,
          ),
        ),
        hintStyle: TextStyle(
          color: Constants.appGrey,
        )),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(
          Constants.appPrimaryColor,
        ),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Constants.appPrimaryColorLight,
      selectionColor: Constants.appPrimaryColorLight.withOpacity(0.4),
      selectionHandleColor: Constants.appPrimaryColorLight,
    ),
    textTheme: ThemeData.light().textTheme.apply(
          bodyColor: Constants.appPrimaryColor,
          fontFamily: 'Poppins',
        ),
    primaryTextTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'Poppins',
        ),
  );
}
