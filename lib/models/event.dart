// lib/models/event.dart
import 'package:isar/isar.dart';
import 'job.dart';

part 'event.g.dart';

@Collection()
class EventModel {
  Id id = Isar.autoIncrement;

  late DateTime date; // 日付
  late String description;
  late String startTime;
  late String endTime;
  late String type; // 'job' or 'task'
  late int breakMinutes;

  // ⭐ 時給フィールド（保存時点の時給）
  double? rate;

  // スナップショット: 予定作成時のJob情報をコピー保存
  // Jobが後で変更・削除されても、この予定の記録は変わらない
  String? jobName; // バイト先名
  double? jobTransportation; // 交通費

  final job = IsarLink<Job>(); // ← Jobへの参照（表示用に残す）

  // コンストラクタ
  EventModel({
    required this.date,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.type,
    required this.breakMinutes,
    this.rate,
    this.jobName,
    this.jobTransportation,
  });

  // デフォルトコンストラクタ（Isarが内部で使用）
  EventModel.empty();
}
