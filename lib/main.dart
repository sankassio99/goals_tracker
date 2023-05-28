import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:goals_tracker/application/usecases/add_new_goal.dart';
import 'package:goals_tracker/application/usecases/add_subgoal.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
import 'package:goals_tracker/application/usecases/get_goals.dart';
import 'package:goals_tracker/application/usecases/get_sub_goals.dart';
import 'package:goals_tracker/application/usecases/update_goal.dart';
import 'package:goals_tracker/infra/goal_repository.dart';
import 'package:goals_tracker/infra/sub_goal_repository.dart';
import 'package:goals_tracker/presentation/controllers/home_controller.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
import 'package:goals_tracker/presentation/controllers/sub_goal_controller.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:goals_tracker/presentation/pages/home_page_widget.dart';
import 'package:goals_tracker/presentation/pages/main_goal_page_widget.dart';
import 'package:goals_tracker/presentation/pages/sub_goal_page_widget.dart';
import 'package:provider/provider.dart';

void main() {
  var goalRepository = GoalRepositoryMemory();
  var subGoalRepository = SubGoalRepositoryMemory();
  var addNewGoal = AddNewGoal(goalRepository);
  var addSubgoal = AddSubgoal(subGoalRepository);
  var updateGoal = UpdateGoal(goalRepository);
  var getGoals = GetGoals(goalRepository);
  var getGoalDetails = GetGoalDetails(goalRepository);
  GetSubGoals getSubGoals = GetSubGoals(subGoalRepository);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeController(
            addNewGoal,
            getGoals,
            updateGoal,
          ),
        ),
        ChangeNotifierProvider(
            create: (_) => MainGoalController(
                updateGoal, addSubgoal, getGoalDetails, getSubGoals)),
        ChangeNotifierProvider(create: (_) => SubGoalController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: themeConfig(),
      routerConfig: router(),
    );
  }
}

router() {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePageWidget(),
      ),
      GoRoute(
          name: "mainGoalDetails",
          path: '/mainGoalDetails',
          builder: (context, state) {
            var goalModel = state.extra as GoalModel;
            return MainGoalPageWidget(
              model: goalModel,
            );
          }),
      GoRoute(
          name: "subGoalDetails",
          path: '/subGoalDetails',
          builder: (context, state) {
            var goalModel = state.extra as GoalModel;
            return SubGoalPageWidget(
              goalModel: goalModel,
            );
          })
    ],
  );
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
        onBackground: Color.fromARGB(255, 254, 214, 140),
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
