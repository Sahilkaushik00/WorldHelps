import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worldhelps/constants/colors.dart';

final ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  scaffoldBackgroundColor: const Color(0xFFEAF0FF),
  useMaterial3: true,
  cupertinoOverrideTheme:
      MaterialBasedCupertinoThemeData(materialTheme: ThemeData.light()),
  fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
  // textTheme: TextTheme(),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: primary,
    elevation: 0,
    titleSpacing: 0,
    titleTextStyle: TextStyle(
      color: primaryWhite,
      // fontWeight: FontWeight.w700,
      fontSize: 20,
    ),
    iconTheme: IconThemeData(
      color: primaryWhite,
    ),
  ),
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
  ),
);
