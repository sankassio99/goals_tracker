abstract class Goal {
  String id;
  String title;
  String desc;
  double completePercentage;
  bool isCompleted;

  Goal(
    this.id,
    this.title,
    this.desc, {
    this.completePercentage = 0,
    this.isCompleted = false,
  });

  double getCompletePercentage();
}
