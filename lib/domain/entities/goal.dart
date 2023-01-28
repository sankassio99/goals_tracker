abstract class Goal {
  String title;
  String desc;
  int completePercent;
  bool completeStutus;

  Goal(
    this.title,
    this.desc, {
    this.completePercent = 0,
    this.completeStutus = false,
  });

  int getCompletePercent();
}
