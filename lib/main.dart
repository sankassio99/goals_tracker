import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/infra/dependecy_binds.dart';
import 'package:goals_tracker/presentation/pages/home_page_widget.dart';
import 'package:goals_tracker/presentation/pages/main_goal_page_widget.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: themeConfig(),
      initialRoute: '/home',
      getPages: [
        GetPage(
            name: '/home',
            page: () => HomePageWidget(),
            binding: HomeBinding()),
        GetPage(
          name: '/mainGoalDetails/:goalId',
          page: () => MainGoalPageWidget(),
          binding: MainGoalBinding(),
        ),
      ],
    );
  }
}

ThemeData themeConfig() {
  return ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.light,
    primaryColor: const Color(0xFF928163),
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xff14181b),
        onPrimary: Color(0xfff1f4f8),
        secondary: Color(0xff14181b),
        onSecondary: Color.fromARGB(255, 102, 99, 146),
        error: Color(0xFF928163),
        onError: Color(0xFF928163),
        background: Color(0xfff1f4f8),
        onBackground: Color.fromARGB(255, 183, 183, 183),
        surface: Color(0xFF928163),
        onSurface: Color.fromARGB(255, 119, 0, 8)),

    // Define the default font family.
    fontFamily: 'Poppins',

    useMaterial3: true,
    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 34.0,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      headlineSmall: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
      bodySmall: TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w500,
        color: Colors.black54,
      ),
      bodyMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    ),
  );
}
