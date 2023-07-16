import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:goals_tracker/infra/dependecy_binds.dart';
import 'package:goals_tracker/presentation/pages/home_page_widget.dart';
import 'package:goals_tracker/presentation/pages/main_goal_page_widget.dart';

void main() async {
  await GetStorage.init("GoalsTracker");
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
      debugShowCheckedModeBanner: false,
    );
  }
}

ThemeData themeConfig() {
  return ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.light,
    primaryColor: const Color(0xFF56B947),
    colorScheme: const ColorScheme(
        primary: Color(0xff14181b),
        secondary: Color(0xFF2C9F42), // Duolingo secondary color
        error: Color(0xFFEF5350), // Duolingo error color
        surface: Color(0xFF56B947), // Duolingo surface color
        brightness: Brightness.light,
        onPrimary: Color(0xFFF1F4F8),
        onSecondary: Color(0xFF0079D3),
        onError: Color(0xFF928163),
        background: Color(0xFFF1F4F8),
        onBackground: Color.fromARGB(255, 183, 183, 183),
        onSurface: Color.fromARGB(255, 119, 0, 8),
        outline: Colors.black12),

    // Define the default font family.
    fontFamily: 'Nunito',

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
