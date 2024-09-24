import 'package:e_tmsc_app/utils/color.dart';
import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      titleTextStyle:
          const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.grey.shade50,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
      hintStyle: const TextStyle(
        fontSize: 14,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.blue,
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: grey900,
    appBarTheme: const AppBarTheme(
      backgroundColor: grey900,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
      hintStyle: const TextStyle(
        fontSize: 14,
      ),
    ),
  );
}
