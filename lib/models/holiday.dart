// lib/models/holiday.dart
import 'package:isar/isar.dart';

part 'holiday.g.dart';

@collection
class Holiday {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late DateTime date; // 祝日の日付

  late String name; // 祝日名（例: "元日", "成人の日"）

  Holiday();

  Holiday.create({
    required this.date,
    required this.name,
  });
}
