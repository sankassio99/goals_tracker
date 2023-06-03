import 'package:flutter_test/flutter_test.dart';
import 'package:goals_tracker/application/usecases/add_new_goal.dart';
import 'package:goals_tracker/application/usecases/get_goals.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:goals_tracker/presentation/controllers/home_controller.dart';
import 'package:mockito/mockito.dart';

import '../add_new_goal_test.mocks.dart';

void main() {
  late HomeController homeController;
  late MockIGoalRepository goalRepository;

  setUp(() async {
    goalRepository = MockIGoalRepository();
    var addNewGoal = AddNewGoal(goalRepository);
    var getGoals = GetGoals(goalRepository);

    goalRepository.save(MainGoal("id", "title", "desc"));

    homeController = HomeController(addNewGoal, getGoals);
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

    test('load goals already saved', () async {
      //#region Arrange(Given)
      var goal1 = MainGoal("1", "title", "desc");
      var goal2 = MainGoal("2", "title", "desc");
      List<MainGoal> mainGoalList = [goal1, goal2];

      when(goalRepository.getAll()).thenAnswer((_) async => mainGoalList);

      //#endregion
      //#region Act(When)
      await homeController.loadGoals();

      //#endregion
      //#region Assert(Then)
      expect(homeController.goalList.length, 2);
      expect(homeController.goalList.first.id, goal1.id);
      expect(homeController.goalList.last.id, goal2.id);

      //#endregion
    });
  });
}
