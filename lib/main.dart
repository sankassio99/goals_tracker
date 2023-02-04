import 'package:flutter/material.dart';
import 'package:goals_tracker/presentation/pages/home_page_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeConfig(),
      home: HomePageWidget(),
    );
  }
}

ThemeData themeConfig() {
  return ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.light,
    primaryColor: const Color(0xFF928163),
    secondaryHeaderColor: const Color(0xFF928163),

    // Define the default font family.
    fontFamily: 'Poppins',

    useMaterial3: true,
    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        headlineLarge: TextStyle(
          fontSize: 34.0,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        )),
  );
}
