import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worldhelps/constants/colors.dart';

final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    scaffoldBackgroundColor: primaryWhite,
    useMaterial3: true,
    cupertinoOverrideTheme:
        MaterialBasedCupertinoThemeData(materialTheme: ThemeData.light()),
    fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
    // textTheme: TextTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(primary),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        minimumSize: MaterialStateProperty.all(
          const Size(double.infinity, 50),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(primary),
      ),
    ));
