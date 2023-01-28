abstract class Goal {
  String title;
  String desc;
  double completePercentage;
  bool isCompleted;

  Goal(
    this.title,
    this.desc, {
    this.completePercentage = 0,
    this.isCompleted = false,
  });

  double getCompletePercentage();
}
