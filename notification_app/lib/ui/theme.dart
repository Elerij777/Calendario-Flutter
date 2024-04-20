import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
    primaryColor: primaryClr,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
    ),
  );
  static final dark = ThemeData(
    primaryColor: darkGreyClr,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: darkHeaderClr,
    ),
  );
}
/*
TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 24, 
      fontWeight:FontWeight.bold
    )
  );
}
TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 30, 
      fontWeight:FontWeight.bold
    )
  );
}
*/
