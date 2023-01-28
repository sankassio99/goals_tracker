import 'package:flutter_test/flutter_test.dart';
import 'package:goals_tracker/domain/entities/task.dart';

void main() {
  setUp(() async {});
  group('Task should', () {
    test('Mark as completed', () async {
      //#region Arrange(Given)
      String title = "Group class";
      Task task = Task(title);
      //#endregion

      //#region Act(When)
      task.markAsCompleted();
      //#endregion

      //#region Assert(Then)
      expect(task.completeStatus, isTrue);
      //#endregion
    });
  });
}
