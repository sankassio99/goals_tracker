import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/add_new_goal.dart';
import 'package:goals_tracker/application/usecases/get_goals.dart';
import 'package:goals_tracker/domain/entities/goal_types_enum.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:goals_tracker/presentation/controllers/home_controller.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:mockito/mockito.dart';
import '../usecases/get_goals_test.mocks.dart';

void main() {
  late HomeController homeController;
  late MockIGoalRepository goalRepository;

  setUp(() async {
    Get.reset();
    goalRepository = MockIGoalRepository();
    var addNewGoal = AddNewGoal(goalRepository);
    var getGoals = GetGoals(goalRepository);

    homeController = HomeController(addNewGoal, getGoals);
  });

  group('Home controller should', () {
    test('add new goal with the correct values', () async {
      //#region Arrange(Given)
      var myGoal = GoalModel(
        "",
        "100",
        name: "My goal",
        goalType: GoalType.monetary,
      );
      //#endregion

      //#region Act(When)
      homeController.addGoal(myGoal);
      //#endregion

      //#region Assert(Then)
      expect(homeController.goalList.length, 1);

      var matcher = predicate<MainGoal>((goal) {
        expect(goal.id, myGoal.id);
        expect(goal.title, myGoal.name.text);
        expect(goal.type, myGoal.meansureType.type);
        expect(goal.target, myGoal.target.text);
        return true;
      });
      verify(goalRepository.save(captureThat(matcher))).called(1);

      //#endregion
    });

    test('load goals already saved', () async {
      //#region Arrange(Given)
      var goal1 = MainGoal("1", "title", "desc", "100");
      var goal2 = MainGoal("2", "title", "desc", "100");
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
