import 'package:flutter_test/flutter_test.dart';
import 'package:goals_tracker/application/usecases/add_new_goal.dart';
import 'package:goals_tracker/application/usecases/get_goals.dart';
import 'package:goals_tracker/application/usecases/update_goal.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:goals_tracker/infra/goal_repository.dart';
import 'package:goals_tracker/presentation/controllers/home_controller.dart';

void main() {
  late HomeController homeController;

  setUp(() async {
    var goalRepository = GoalRepositoryMemory();
    var addNewGoal = AddNewGoal(goalRepository);
    var updateGoal = UpdateGoal(goalRepository);
    var getGoals = GetGoals(goalRepository);

    goalRepository.save(MainGoal("id", "title", "desc"));

    homeController = HomeController(addNewGoal, getGoals, updateGoal);
  });

  group('Home controller should', () {
    test('list all main goals', () async {
      //#region Arrange(Given)
      var startingGoalList = homeController.goalList;
      var called = 0;
      homeController.addListener(() {
        expect(
          homeController.goalList.length,
          greaterThan(startingGoalList.length),
        );
        called++;
      });
      //#endregion

      //#region Act(When)
      await homeController.getAllGoals();
      //#endregion

      //#region Assert(Then)
      expect(called, 1);
      //#endregion
    });
  });
}
