import 'package:goals_tracker/domain/entities/deposit_entry.dart';

class DepositEntryModel {
  final double value;
  DepositEntryModel(this.value);

  DepositEntry toEntity() {
    return DepositEntry(value);
  }
}
