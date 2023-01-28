class Task {
  String title;
  bool completeStatus;

  Task(this.title, {this.completeStatus = false});

  bool get isCompleted => completeStatus;

  void markAsCompleted() {}
}
