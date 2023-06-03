import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/application/adapters/igoal_repository.dart';
import 'package:goals_tracker/application/usecases/add_new_goal.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
import 'package:goals_tracker/presentation/controllers/home_controller.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
import 'package:goals_tracker/presentation/pages/home_page_widget.dart';
import 'package:goals_tracker/presentation/pages/main_goal_page_widget.dart';

class MyAppFake extends StatelessWidget {
  final IGoalRepository goalRepository;
  const MyAppFake({super.key, required this.goalRepository});

  // This widget is the root of your application test.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Tests',
      initialRoute: '/home',
      getPages: [
        GetPage(
          name: '/home',
          page: () => HomePageWidget(),
          binding: HomeBindingFake(goalRepository),
        ),
        GetPage(
          name: '/mainGoalDetails/:goalId',
          page: () => MainGoalPageWidget(),
          binding: MainGoalBindingFake(goalRepository),
        ),
      ],
    );
  }
}

class MainGoalBindingFake extends Bindings {
  late IGoalRepository goalRepository;

  MainGoalBindingFake(this.goalRepository);

  @override
  void dependencies() {
    var getGoalDetails = GetGoalDetails(goalRepository);
    Get.lazyPut(() => MainGoalController(getGoalDetails));
  }
}

class HomeBindingFake extends Bindings {
  late IGoalRepository goalRepository;

  HomeBindingFake(this.goalRepository);

  @override
  void dependencies() {
    var addNewGoal = AddNewGoal(goalRepository);
    Get.lazyPut(() => HomeController(addNewGoal));
  }
}
