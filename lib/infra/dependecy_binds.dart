import 'package:get/get.dart';
import 'package:goals_tracker/application/adapters/igoal_repository.dart';
import 'package:goals_tracker/application/usecases/add_new_goal.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
import 'package:goals_tracker/application/usecases/get_goals.dart';
import 'package:goals_tracker/application/usecases/update_goal.dart';
import 'package:goals_tracker/infra/goal_repository_memory.dart';
import 'package:goals_tracker/infra/goal_repository_storage.dart';
import 'package:goals_tracker/presentation/controllers/home_controller.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';

class MainGoalBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<IGoalRepository>()) {
      Get.lazyPut<IGoalRepository>(() => GoalRepositoryStorage());
    }

    var goalRepository = Get.find<IGoalRepository>();

    var getGoalDetails = GetGoalDetails(goalRepository);
    var updateGoal = UpdateGoal(goalRepository);

    Get.lazyPut(() => MainGoalController(getGoalDetails, updateGoal));
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<IGoalRepository>()) {
      Get.lazyPut<IGoalRepository>(() => GoalRepositoryStorage());
    }
    var goalRepository = Get.find<IGoalRepository>();

    var addNewGoal = AddNewGoal(goalRepository);
    var getGoals = GetGoals(goalRepository);
    Get.lazyPut(() => HomeController(addNewGoal, getGoals));
  }
}
