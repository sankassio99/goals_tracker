enum GoalType {
  /// ex: Invest 2000 dollars
  monetary,

  /// Is default goal type
  ///
  /// ex: learn english
  /// ex: read 10 books
  ///
  /// If is not define the goal (value)
  ///   must be calculate (completed tasks/existent tasks)
  tasks,

  /// ex: go to the gym for 200 days
  days,
}
