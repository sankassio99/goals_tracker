import 'package:flutter_test/flutter_test.dart';
import 'package:goals_tracker/application/usecases/add_new_goal.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:goals_tracker/infra/goal_repository.dart';
import 'package:goals_tracker/presentation/controllers/home_controller.dart';

void main() {
  late HomeController homeController;

  setUp(() async {
    var goalRepository = GoalRepositoryMemory();
    var addNewGoal = AddNewGoal(goalRepository);

    goalRepository.save(MainGoal("id", "title", "desc"));

    homeController = HomeController(addNewGoal);
  });

  group('Home controller should', () {
    test('add new goal', () async {
      //#region Arrange(Given)
      //#endregion

      //#region Act(When)
      homeController.addNewGoal();
      //#endregion

      //#region Assert(Then)
      expect(homeController.goalList.length, 1);
      //#endregion
    });
  });
}
