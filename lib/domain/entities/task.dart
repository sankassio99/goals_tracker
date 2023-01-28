class Task {
  String title;
  bool isCompleted;

  Task(this.title, {this.isCompleted = false});

  bool get completeStatus => isCompleted;

  void markAsCompleted() {
    isCompleted = true;
  }
}
