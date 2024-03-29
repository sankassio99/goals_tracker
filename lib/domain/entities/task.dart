class Task {
  String title;
  bool isCompleted;

  Task(this.title, {this.isCompleted = false});

  bool get completeStatus => isCompleted;

  void markAsCompleted() {
    isCompleted = true;
  }

  void markOff() {
    isCompleted = false;
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      json['title'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}
