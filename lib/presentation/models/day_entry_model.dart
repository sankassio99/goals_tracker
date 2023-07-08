class DayEntryModel {
  DateTime value;

  DayEntryModel(this.value);

  Map<String, dynamic> toJson() {
    return {
      'value': value.toIso8601String(),
    };
  }

  factory DayEntryModel.fromJson(Map<String, dynamic> json) {
    var value = DateTime.parse(json['value']);
    return DayEntryModel(value);
  }
}
