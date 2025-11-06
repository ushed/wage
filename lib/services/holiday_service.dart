// lib/services/holiday_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:isar/isar.dart';
import '../models/holiday.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HolidayService {
  final Isar isar;
  static const String apiUrl = 'https://holidays-jp.github.io/api/v1/date.json';
  static const String lastUpdateKey = 'holiday_last_update';

  HolidayService(this.isar);

  /// 祝日データを取得・更新（1日1回まで）
  Future<void> updateHolidaysIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    final lastUpdate = prefs.getString(lastUpdateKey);
    final today = DateTime.now().toIso8601String().substring(0, 10);

    // 今日既に更新済みならスキップ
    if (lastUpdate == today) return;

    try {
      final response = await http.get(Uri.parse(apiUrl)).timeout(
            const Duration(seconds: 10),
          );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        await _saveHolidays(data);
        await prefs.setString(lastUpdateKey, today);
      }
    } catch (e) {
      // ネットワークエラーは無視（既存データを使用）
      print('祝日データの更新に失敗: $e');
    }
  }

  /// 祝日データをIsarに保存
  Future<void> _saveHolidays(Map<String, dynamic> data) async {
    final holidays = <Holiday>[];

    for (var entry in data.entries) {
      final date = DateTime.parse(entry.key);
      final name = entry.value as String;

      holidays.add(Holiday.create(date: date, name: name));
    }

    await isar.writeTxn(() async {
      // 既存データをクリア
      await isar.holidays.clear();
      // 新しいデータを保存
      await isar.holidays.putAll(holidays);
    });
  }

  /// 指定日が祝日かチェック
  Future<Holiday?> getHoliday(DateTime date) async {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    return await isar.holidays.filter().dateEqualTo(normalizedDate).findFirst();
  }

  /// 指定月の祝日を取得
  Future<List<Holiday>> getHolidaysInMonth(int year, int month) async {
    final startOfMonth = DateTime(year, month, 1);
    final endOfMonth = DateTime(year, month + 1, 0, 23, 59, 59);

    return await isar.holidays
        .filter()
        .dateBetween(startOfMonth, endOfMonth)
        .findAll();
  }
}
