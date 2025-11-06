// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import '../theme.dart' as theme; // customSwatchを使用するためにインポート
import 'package:isar/isar.dart'; // Isarを追加
import '../models/event.dart'; // IsarのEventModelをインポート

// UI描画に必要なモデル
class MonthlySalaryData {
  final double totalHours;
  final double totalSalary;

  MonthlySalaryData({required this.totalHours, required this.totalSalary});
}

class HomeScreen extends StatefulWidget {
  // Isarインスタンスを受け取る
  final Isar isar;
  const HomeScreen({super.key, required this.isar});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  // 状態変数をIsarモデル（EventModel）で初期化
  List<EventModel> _todayEvents = [];
  Map<DateTime, List<EventModel>> _weeklyEventsMap = {};
  bool _isLoading = false;
  DateTime _focusedDay = DateTime.now();
  MonthlySalaryData _currentMonthSalary =
      MonthlySalaryData(totalHours: 0, totalSalary: 0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _focusedDay = DateTime(
      _focusedDay.year,
      _focusedDay.month,
      _focusedDay.day,
    );
    _loadAllData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadAllData();
    }
  }

  /// Isarからデータをロードするロジック
  Future<void> _loadAllData() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // 今日の開始時間と終了時間
    final startOfToday = today;
    final endOfToday = today
        .add(const Duration(days: 1))
        .subtract(const Duration(milliseconds: 1));

    // 今月の開始日と来月の開始日
    final startOfMonth = DateTime(now.year, now.month, 1);
    final startOfNextMonth = DateTime(now.year, now.month + 1, 1);

    // 今週の開始日 (月曜日)
    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));

    // --- 1. 今日の予定 ---
    final todayEvents = await widget.isar.eventModels
        .filter()
        .dateBetween(startOfToday, endOfToday)
        .sortByStartTime()
        .findAll();

    // --- 2. 今月の給与情報（合計勤務時間と予定給与） ---
    final currentMonthEvents = await widget.isar.eventModels
        .filter()
        .typeEqualTo('job') // バイトのみを対象
        .dateBetween(startOfMonth,
            startOfNextMonth.subtract(const Duration(milliseconds: 1)))
        .findAll();

    double totalHours = 0;
    double totalSalary = 0;

    for (var event in currentMonthEvents) {
      // 時刻文字列をパース
      final startParts = event.startTime.split(':').map(int.parse).toList();
      final endParts = event.endTime.split(':').map(int.parse).toList();

      DateTime startDateTime = event.date
          .add(Duration(hours: startParts[0], minutes: startParts[1]));
      DateTime endDateTime =
          event.date.add(Duration(hours: endParts[0], minutes: endParts[1]));

      // 日をまたぐシフトの処理 (例: 22:00-06:00)
      if (endDateTime.isBefore(startDateTime)) {
        endDateTime = endDateTime.add(const Duration(days: 1));
      }

      final duration = endDateTime.difference(startDateTime);
      // 休憩時間を引く (分を時間に変換)
      final workDurationHours =
          duration.inMinutes / 60.0 - (event.breakMinutes / 60.0);

      // 労働時間の合計
      if (workDurationHours > 0) {
        totalHours += workDurationHours;

        // 予定給与の計算 (rateは時給)
        final rate = event.rate ?? 0.0;
        totalSalary += workDurationHours * rate;
      }
    }

    // --- 3. 今週の予定 ---
    _weeklyEventsMap = {};
    for (int i = 0; i < 7; i++) {
      DateTime day = startOfWeek.add(Duration(days: i));
      DateTime startOfDay = DateTime(day.year, day.month, day.day);
      DateTime endOfDay = startOfDay
          .add(const Duration(days: 1))
          .subtract(const Duration(milliseconds: 1));

      final eventsOfDay = await widget.isar.eventModels
          .filter()
          .dateBetween(startOfDay, endOfDay)
          .sortByStartTime()
          .findAll();

      if (eventsOfDay.isNotEmpty) {
        _weeklyEventsMap[startOfDay] = eventsOfDay;
      }
    }

    if (mounted) {
      setState(() {
        _todayEvents = todayEvents;
        _currentMonthSalary =
            MonthlySalaryData(totalHours: totalHours, totalSalary: totalSalary);
        _isLoading = false;
      });
    }
  }

  String _formatCurrency(double amount) {
    return '¥${amount.toStringAsFixed(0)}';
  }

  String _formatHours(double hours) {
    return '${hours.toStringAsFixed(1)} h';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAllData,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadAllData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // --- 1. 今日の予定セクション ---
              _buildSectionCard(
                icon: Icons.today,
                title: '今日の予定 (${_todayEvents.length}件)',
                content: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _todayEvents.isEmpty
                        ? const Text('今日は予定がありません。')
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _todayEvents
                                .map((event) => _buildScheduleItem(event))
                                .toList(),
                          ),
              ),
              const SizedBox(height: 20),

              // --- 2. 今月の給与情報セクション ---
              _buildSectionCard(
                icon: Icons.attach_money,
                title: '今月の給与情報 (${DateTime.now().month}月)',
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSalaryDetail(
                                  '合計勤務時間',
                                  _formatHours(_currentMonthSalary.totalHours),
                                  Icons.access_time),
                              const SizedBox(height: 8),
                              _buildSalaryDetail(
                                  '予定給与合計',
                                  _formatCurrency(
                                      _currentMonthSalary.totalSalary),
                                  Icons.paid,
                                  theme.customSwatch[700]),
                            ],
                          ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // --- 3. 今週の予定セクション ---
              _buildSectionCard(
                icon: Icons.calendar_view_week,
                title: '今週の予定',
                content: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _weeklyEventsMap.isEmpty
                        ? const Text('今週の予定はありません。')
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _weeklyEventsMap.keys.map((date) {
                              final events = _weeklyEventsMap[date]!;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${date.month}/${date.day} (${_getWeekday(date.weekday)})',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: theme.customSwatch[800],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    events.isEmpty
                                        ? const Text('予定なし')
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: events
                                                .map((event) =>
                                                    _buildScheduleItem(event))
                                                .toList(),
                                          ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return '月';
      case 2:
        return '火';
      case 3:
        return '水';
      case 4:
        return '木';
      case 5:
        return '金';
      case 6:
        return '土';
      case 7:
        return '日';
      default:
        return '';
    }
  }

  Widget _buildSalaryDetail(String label, String value, IconData icon,
      [Color? valueColor]) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: valueColor ?? Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required Widget content,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, color: theme.customSwatch[700]),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleItem(EventModel event) {
    // EventModelに変更
    String timeRange = '';
    // EventModelのstartTimeとendTimeを使用
    timeRange = '${event.startTime}～${event.endTime}';

    String title = event.description;
    Color color = Colors.blue;

    // EventModelのtypeフィールドはString ('job' または 'task')
    if (event.type == 'job') {
      // 'job'と比較
      // Job名はEventModelのスナップショットフィールドから取得
      title = event.jobName ?? 'Unknown Job';
      if (event.description.isNotEmpty && event.description != "バイト") {
        title += ' (${event.description})';
      }
      color = Colors.green;
    } else {
      // 'task' (プライベート)
      color = Colors.orange;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(timeRange, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(child: Text(title, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
