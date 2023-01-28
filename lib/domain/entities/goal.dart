abstract class Goal {
  String title;
  String desc;
  int completePercent;
  bool compleStutus;

  Goal(this.title, this.desc, this.completePercent, this.compleStutus);

  getCompletePercent();
}
