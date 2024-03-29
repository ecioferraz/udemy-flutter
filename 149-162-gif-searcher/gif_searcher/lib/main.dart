import 'package:flutter/material.dart';
import 'package:gif_searcher/ui/home_page.dart';

void main() {
  runApp(MaterialApp(
    home: const HomePage(),
    theme: ThemeData(
      hintColor: Colors.white,
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        hintStyle: TextStyle(color: Colors.white),
      ),
      primaryColor: Colors.white,
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: Colors.white),
    ),
  ));
}
