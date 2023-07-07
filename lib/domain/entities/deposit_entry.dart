class DepositEntry {
  final double value;
  DepositEntry(this.value);

  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }

  factory DepositEntry.fromJson(Map<String, dynamic> json) {
    return DepositEntry(
      json['value'] ?? '',
    );
  }
}
