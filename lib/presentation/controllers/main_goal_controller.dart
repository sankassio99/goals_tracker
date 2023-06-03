import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';

class MainGoalController extends GetxController {
  var goalModel;

  MainGoalController(GetGoalDetails getGoalDetails);

  @override
  void onInit() {
    print("On initi called");
    print(Get.parameters['goalId']);
    super.onInit();
  }
}
