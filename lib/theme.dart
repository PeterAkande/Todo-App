//This class would handle everything that has to do with themes

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/constants.dart';

//Would change all these later.
class TodoTheme {
  //Change maybe to exo or montesarrat soon or lato
  static TextTheme lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.exo(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline1: GoogleFonts.exo(
      fontSize: 29.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline2: GoogleFonts.exo(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline3: GoogleFonts.exo(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headline4: GoogleFonts.exo(
      fontSize: 12.0,
      fontWeight: FontWeight.w200,
      color: Colors.black,
    ),
    headline5: GoogleFonts.exo(
      fontSize: 10.5,
      fontWeight: FontWeight.w100,
      color: Colors.black,
    ),
    headline6: GoogleFonts.exo(
      fontSize: 9.0,
      fontWeight: FontWeight.w100,
      color: Colors.black,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.exo(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline1: GoogleFonts.exo(
      fontSize: 29.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline2: GoogleFonts.exo(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline3: GoogleFonts.exo(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline4: GoogleFonts.exo(
      fontSize: 12.0,
      fontWeight: FontWeight.w200,
      color: Colors.white,
    ),
    headline5: GoogleFonts.exo(
      fontSize: 10.5,
      fontWeight: FontWeight.w100,
      color: Colors.white,
    ),
    headline6: GoogleFonts.exo(
      fontSize: 9.0,
      fontWeight: FontWeight.w100,
      color: Colors.white,
    ),
  );

  static ThemeData light() {
    return ThemeData(
        buttonTheme: const ButtonThemeData(buttonColor: appSecondaryColorLight),
        dialogBackgroundColor: Colors.white,
        primaryColor: appPrimaryColorLight,
        backgroundColor: appPrimaryColorLight,
        brightness: Brightness.light,
        primaryColorLight: Colors.white,
        cardColor: Colors.white,
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateColor.resolveWith((states) {
            return Colors.black;
          }),
        ),
        appBarTheme: const AppBarTheme(
          //foregroundColor: Colors.white,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        scaffoldBackgroundColor: appPrimaryColorLight,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            foregroundColor: Colors.white,
            backgroundColor: appSecondaryColorLight,
            elevation: 0),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.red,
          // unselectedItemColor: Colors.white,
          backgroundColor: Colors.white,
        ),
        textTheme: lightTextTheme,
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.white,
        ));
  }

  static ThemeData dark() {
    return ThemeData(
        dialogBackgroundColor: Colors.black,
        cardColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        brightness: Brightness.dark,
        primaryColorDark: Colors.black,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          backgroundColor: appPrimaryColorLight,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: appPrimaryColorDark,
        ),
        textTheme: darkTextTheme,
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.black,
        ));
  }
}
