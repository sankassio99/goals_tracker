import 'package:get/get.dart';
import 'package:goals_tracker/application/adapters/igoal_repository.dart';
import 'package:goals_tracker/application/usecases/add_new_goal.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
import 'package:goals_tracker/infra/goal_repository.dart';
import 'package:goals_tracker/presentation/controllers/home_controller.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';

class MainGoalBinding extends Bindings {
  @override
  void dependencies() {
    var goalRepository = Get.isRegistered<IGoalRepository>()
        ? Get.find<IGoalRepository>()
        : GoalRepositoryMemory();

    var getGoalDetails = GetGoalDetails(goalRepository);

    Get.lazyPut(() => MainGoalController(getGoalDetails));
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    var goalRepository = Get.isRegistered<IGoalRepository>()
        ? Get.find<IGoalRepository>()
        : GoalRepositoryMemory();

    var addNewGoal = AddNewGoal(goalRepository);
    Get.lazyPut(() => HomeController(addNewGoal));
  }
}
