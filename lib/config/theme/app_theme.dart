import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const colorSeed = Color(0xff14967f);
const scaffoldBackgroundColor = Color(0xFFF8F7F7);
const primaryColor = Color(0xff14967f);
const secondaryColor = Color(0xff095d7e);
const errorColor = Color(0xFFB00020);

class AppTheme {
  ThemeData getTheme() => ThemeData(

      ///* General
      useMaterial3: true,

      /// Colores del esquema de la aplicación
      colorScheme: ColorScheme.fromSeed(
        seedColor: colorSeed,
        primary: primaryColor,
        secondary: secondaryColor,
        error: errorColor,
        brightness: Brightness.light, // Para modo claro
      ),

      ///* Texts
      textTheme: TextTheme(
          titleLarge: GoogleFonts.montserratAlternates()
              .copyWith(fontSize: 40, fontWeight: FontWeight.bold),
          titleMedium: GoogleFonts.montserratAlternates()
              .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
          titleSmall:
              GoogleFonts.montserratAlternates().copyWith(fontSize: 20)),

      ///* Scaffold Background Color
      scaffoldBackgroundColor: scaffoldBackgroundColor,

      ///* Buttons
      filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
              textStyle: WidgetStatePropertyAll(
                  GoogleFonts.montserratAlternates()
                      .copyWith(fontWeight: FontWeight.w700)))),

      ///* AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor, // Fondo de la barra
        foregroundColor: Colors.white, // Color de los textos/íconos
        elevation: 0,
        titleTextStyle: GoogleFonts.montserratAlternates(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ));
}
