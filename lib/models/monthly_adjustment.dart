// lib/models/monthly_adjustment.dart
import 'package:isar/isar.dart';

part 'monthly_adjustment.g.dart';

@Collection()
class MonthlyAdjustment {
  Id id = Isar.autoIncrement;

  late String yearMonth; // "2025/10" 形式
  late double adjustmentAmount;
  late String adjustmentReason;

  @Index(unique: true)
  String get yearMonthIndex => yearMonth;
}
