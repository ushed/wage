// lib/models/job.dart

import 'package:isar/isar.dart';

part 'job.g.dart'; // Isar用のコード生成ファイル

@Collection()
class Job {
  Job({required this.name, required this.rates, required this.transportation});

  Id id = Isar.autoIncrement; // 自動ID

  late String name;

  // 時給パターン
  late List<double> rates;

  // 交通費
  late double transportation;

  // 表示用の時給文字列
  @Ignore()
  String get displayRate => rates.map((r) => r.toInt()).join(' / ');

  // コピーして更新するためのメソッド
  Job copyWith({String? name, List<double>? rates, double? transportation}) {
    return Job(
      name: name ?? this.name,
      rates: rates ?? this.rates,
      transportation: transportation ?? this.transportation,
    )..id = id; // idは保持
  }
}
