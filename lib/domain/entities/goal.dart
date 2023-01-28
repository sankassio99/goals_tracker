abstract class Goal {
  String title;
  String desc;
  double completePercent;
  bool completeStutus;

  Goal(
    this.title,
    this.desc, {
    this.completePercent = 0,
    this.completeStutus = false,
  });

  double getCompletePercent();
}
