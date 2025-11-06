// lib/screens/schedule_screen.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme.dart';
import '../models/job.dart';
import '../models/event.dart';
import '../models/holiday.dart';
import '../services/holiday_service.dart';

class ScheduleScreen extends StatefulWidget {
  final Isar isar;
  const ScheduleScreen({super.key, required this.isar});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with WidgetsBindingObserver {
  static const String _lastJobIdKey = 'last_used_job_id';

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<EventModel> _allEvents = [];
  List<EventModel> _selectedEvents = [];

  bool _isLoading = false;
  List<Job> _jobs = [];

  late HolidayService _holidayService;
  Map<DateTime, Holiday> _holidaysCache = {};

  // TimeOfDayをパースするヘルパー
  TimeOfDay? _parseTimeOfDay(String time) {
    try {
      final parts = time.split(':');
      if (parts.length != 2) return null;
      final hour = int.tryParse(parts[0]);
      final minute = int.tryParse(parts[1]);
      if (hour != null && minute != null) {
        return TimeOfDay(hour: hour, minute: minute);
      }
    } catch (e) {
      // パース失敗
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _selectedDay = _focusedDay;

    _holidayService = HolidayService(widget.isar);
    _holidayService.updateHolidaysIfNeeded();

    // Jobの監視を開始
    widget.isar.jobs.watchLazy().listen((_) {
      _loadJobs();
    });

    // Eventの監視を開始
    widget.isar.eventModels.watchLazy().listen((_) {
      _loadAllData();
    });

    // 初期データ読み込み
    _loadJobs();
    _loadAllData();
    _loadHolidays();
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

  Future<void> _loadHolidays() async {
    final holidays = await _holidayService.getHolidaysInMonth(
      _focusedDay.year,
      _focusedDay.month,
    );

    if (mounted) {
      setState(() {
        _holidaysCache = {
          for (var holiday in holidays)
            DateTime(holiday.date.year, holiday.date.month, holiday.date.day):
                holiday
        };
      });
    }
  }

  // ⭐ 最後に使ったJobを取得
  Future<Job?> _getLastUsedJob() async {
    final prefs = await SharedPreferences.getInstance();
    final lastJobId = prefs.getInt(_lastJobIdKey);

    if (lastJobId != null && _jobs.isNotEmpty) {
      try {
        return _jobs.firstWhere((job) => job.id == lastJobId);
      } catch (e) {
        // 削除されていた場合はnullを返す
        return null;
      }
    }
    return null;
  }

  // ⭐ 最後に使ったJobを保存
  Future<void> _saveLastUsedJob(int jobId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastJobIdKey, jobId);
  }

  // Jobリストを読み込む
  Future<void> _loadJobs() async {
    final jobs = await widget.isar.jobs.where().findAll();
    if (mounted) {
      setState(() => _jobs = jobs);
    }
  }

  // すべてのイベントを読み込む
  Future<void> _loadAllData() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    // Isarからすべてのイベントを取得
    final events = await widget.isar.eventModels.where().findAll();

    // 各イベントのJobリレーションを読み込む
    for (var event in events) {
      await event.job.load();
    }

    if (mounted) {
      setState(() {
        _allEvents = events;
        _selectedEvents = _getEventsForDay(_selectedDay!);
        _isLoading = false;
      });
    }
  }

  // 指定日のイベントを取得
  List<EventModel> _getEventsForDay(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return _allEvents.where((event) {
      final eventDay =
          DateTime(event.date.year, event.date.month, event.date.day);
      return eventDay == normalizedDay;
    }).toList();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents = _getEventsForDay(selectedDay);
      });
    }
  }

  void _onFormatChanged(CalendarFormat format) {
    if (_calendarFormat != format) {
      setState(() => _calendarFormat = format);
    }
  }

  void _onPageChanged(DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
    });
    _loadHolidays();
  }

  // イベントを追加
  Future<void> _addEvent(EventModel event) async {
    await widget.isar.writeTxn(() async {
      await widget.isar.eventModels.put(event);
      // Jobリレーションを保存
      await event.job.save();
    });
  }

  // イベントを更新
  Future<void> _updateEvent(EventModel event) async {
    await widget.isar.writeTxn(() async {
      await widget.isar.eventModels.put(event);
      await event.job.save();
    });
  }

  // イベントを削除
  Future<void> _deleteEvent(EventModel event) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('削除確認'),
        content: const Text('この予定を削除してもよろしいですか?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('キャンセル'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('削除'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await widget.isar.writeTxn(() async {
        await widget.isar.eventModels.delete(event.id);
      });
    }
  }

  void _showEventTypeDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              leading: Icon(Icons.work, color: customSwatch[600]),
              title: const Text('バイトの予定を追加'),
              onTap: () {
                Navigator.pop(context);
                _showAddJobEventDialog();
              },
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              leading: const Icon(Icons.task, color: Colors.orange),
              title: const Text('その他の予定を追加'),
              onTap: () {
                Navigator.pop(context);
                _showAddTaskEventDialog();
              },
            ),
            const SizedBox(height: 30.0),
          ],
        );
      },
    );
  }

// ────── バイト予定追加・編集 ──────
  void _showAddJobEventDialog({EventModel? eventToEdit}) async {
    final formKey = GlobalKey<FormState>();
    final isEditing = eventToEdit != null;

    Job? selectedJob;
    double? selectedRate;
    bool useCustomRate = false; // カスタム時給を使うかどうか

    if (!isEditing && _jobs.isNotEmpty) {
      final lastJob = await _getLastUsedJob();
      if (lastJob != null) {
        selectedJob = lastJob;
        if (lastJob.rates.isNotEmpty) {
          selectedRate = lastJob.rates.first;
        }
      }
    } else if (isEditing) {
      if (eventToEdit!.job.value != null) {
        final existingJobId = eventToEdit.job.value!.id;
        try {
          selectedJob = _jobs.firstWhere((job) => job.id == existingJobId);
          selectedRate = eventToEdit.rate;
          if (selectedRate != null &&
              !selectedJob.rates.contains(selectedRate)) {
            useCustomRate = true;
          }
        } catch (e) {
          if (_jobs.isNotEmpty) {
            selectedJob = _jobs.first;
            selectedRate =
                selectedJob.rates.isNotEmpty ? selectedJob.rates.first : null;
          }
        }
      } else if (_jobs.isNotEmpty) {
        selectedJob = _jobs.first;
        selectedRate =
            selectedJob.rates.isNotEmpty ? selectedJob.rates.first : null;
      }
    }

    String description = eventToEdit?.description ?? '';
    String startTime = eventToEdit?.startTime ?? '09:00';
    String endTime = eventToEdit?.endTime ?? '19:00';
    int breakMinutes = eventToEdit?.breakMinutes ?? 0;

    // ⭐ 時給入力用のコントローラ
    final rateController = TextEditingController(
      text: selectedRate != null
          ? (selectedRate == selectedRate!.toInt()
              ? selectedRate!.toInt().toString()
              : selectedRate.toString())
          : '',
    );

    // ⭐ 1. addListener と listener 変数を「完全に削除」します。

    // ⭐ Jobsが空の場合は警告を表示して終了
    if (_jobs.isEmpty) {
      // ⭐ 2. dispose() のみ呼び出します。
      rateController.dispose();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('バイト先が登録されていません'),
          content: const Text('「Works」画面でバイト先を追加してから予定を登録してください。'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateSB) {
            return AlertDialog(
              title: Text(isEditing ? 'バイト予定の編集' : 'バイト予定の追加'),
              content: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ▼ バイト先選択
                      DropdownButtonFormField<Job>(
                        decoration: const InputDecoration(labelText: 'バイト先'),
                        value: selectedJob,
                        items: _jobs
                            .map((job) => DropdownMenuItem(
                                  value: job,
                                  child: Text(job.name),
                                ))
                            .toList(),
                        onChanged: (job) {
                          setStateSB(() {
                            selectedJob = job;
                            // バイト先が変わったら、時給の初期値をセットし直す
                            if (job != null && job.rates.isNotEmpty) {
                              selectedRate = job.rates.first;
                              useCustomRate = false; // カスタムモード解除
                            } else {
                              selectedRate = null;
                            }
                            // コントローラにも反映
                            rateController.text = selectedRate != null
                                ? (selectedRate == selectedRate!.toInt()
                                    ? selectedRate!.toInt().toString()
                                    : selectedRate!.toString())
                                : '';
                          });
                        },
                        validator: (value) =>
                            value == null ? 'バイト先を選択してください' : null,
                      ),

                      // ==========================================
                      // ▼ 時給選択・入力
                      // ==========================================
                      if (selectedJob != null) ...[
                        // --- 1. カスタム入力モードの場合 (useCustomRate == true) ---
                        if (useCustomRate)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: rateController,
                                decoration: const InputDecoration(
                                  labelText: '時給 (円)',
                                  suffixText: '円',
                                ),
                                keyboardType: TextInputType.number,
                                // ⭐ 3. addListener の代わりに onChanged を使用します。
                                // これで手入力が selectedRate 変数に反映されます。
                                onChanged: (value) {
                                  selectedRate = double.tryParse(value);
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '時給を入力してください';
                                  }
                                  final rate = double.tryParse(value);
                                  if (rate == null || rate <= 0) {
                                    return '有効な数値を入力してください';
                                  }
                                  return null;
                                },
                              ),
                              if (selectedJob!.rates.isNotEmpty)
                                TextButton.icon(
                                  icon: const Icon(Icons.list, size: 16),
                                  label: const Text('登録済みの時給から選択'),
                                  onPressed: () {
                                    setStateSB(() {
                                      useCustomRate = false;
                                      selectedRate = selectedJob!.rates.first;
                                      // コントローラのテキストも更新
                                      rateController.text =
                                          selectedRate!.toInt().toString();
                                    });
                                  },
                                ),
                            ],
                          ),

                        // --- 2. 選択モードの場合 (useCustomRate == false) ---
                        if (!useCustomRate) ...[
                          // 2a. 登録済み時給が「ある」場合
                          if (selectedJob!.rates.isNotEmpty)
                            Column(
                              children: [
                                DropdownButtonFormField<double>(
                                  decoration:
                                      const InputDecoration(labelText: '時給'),
                                  value: selectedRate,
                                  items: selectedJob!.rates
                                      .map((rate) => DropdownMenuItem(
                                            value: rate,
                                            child: Text(
                                                '${rate == rate.toInt() ? rate.toInt() : rate} 円'),
                                          ))
                                      .toList(),
                                  // ⭐ 4. ドロップダウン変更で selectedRate を更新
                                  onChanged: (rate) =>
                                      setStateSB(() => selectedRate = rate),
                                  validator: (value) =>
                                      value == null ? '時給を選択してください' : null,
                                ),
                                // 「カスタム入力に切り替える」ボタン
                                TextButton.icon(
                                  icon: const Icon(Icons.edit, size: 16),
                                  label: const Text('別の時給を入力'),
                                  onPressed: () {
                                    setStateSB(() {
                                      useCustomRate = true;
                                      // ⭐ 5. selectedRate の値は変えずに、
                                      //     コントローラのテキストだけ更新する
                                      rateController.text = selectedRate != null
                                          ? (selectedRate ==
                                                  selectedRate!.toInt()
                                              ? selectedRate!.toInt().toString()
                                              : selectedRate!.toString())
                                          : '';
                                    });
                                  },
                                ),
                              ],
                            ),

                          // 2b. 登録済み時給が「ない」場合
                          if (selectedJob!.rates.isEmpty)
                            Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    '※ 選択したバイト先には時給が登録されていません。',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.orange),
                                  ),
                                ),
                                TextButton.icon(
                                  icon: const Icon(Icons.edit, size: 16),
                                  label: const Text('時給を直接入力'),
                                  onPressed: () {
                                    setStateSB(() {
                                      useCustomRate = true;
                                      selectedRate = null; // 時給をリセット
                                      rateController.text = ''; // テキストもリセット
                                    });
                                  },
                                ),
                              ],
                            ),
                        ],
                      ],

                      TextFormField(
                        decoration: const InputDecoration(labelText: '追記'),
                        initialValue: description,
                        onChanged: (value) => description = value,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                final now = TimeOfDay.now();
                                final parsedTime = _parseTimeOfDay(startTime);
                                final picked = await showTimePicker(
                                  context: context,
                                  initialTime: parsedTime ??
                                      TimeOfDay(hour: now.hour, minute: 0),
                                );
                                if (picked != null) {
                                  setStateSB(() => startTime =
                                      '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}');
                                }
                              },
                              child: AbsorbPointer(
                                child: TextFormField(
                                  decoration:
                                      const InputDecoration(labelText: '開始時間'),
                                  controller:
                                      TextEditingController(text: startTime),
                                  key: ValueKey('start_$startTime'),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                final parsedTime = _parseTimeOfDay(endTime);
                                final picked = await showTimePicker(
                                  context: context,
                                  initialTime: parsedTime ??
                                      TimeOfDay(
                                          hour: (parsedTime?.hour ?? 17) + 1,
                                          minute: parsedTime?.minute ?? 0),
                                );
                                if (picked != null) {
                                  setStateSB(() => endTime =
                                      '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}');
                                }
                              },
                              child: AbsorbPointer(
                                child: TextFormField(
                                  decoration:
                                      const InputDecoration(labelText: '終了時間'),
                                  controller:
                                      TextEditingController(text: endTime),
                                  key: ValueKey('end_$endTime'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: '休憩時間 (分)'),
                        initialValue: breakMinutes.toString(),
                        keyboardType: TextInputType.number,
                        onChanged: (value) =>
                            breakMinutes = int.tryParse(value) ?? 0,
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      // ⭐ 6. listener の削除は不要。 dispose のみ。
                      rateController.dispose();
                      Navigator.pop(context);
                    },
                    child: const Text('キャンセル')),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate() &&
                        selectedJob != null &&
                        selectedRate != null) {
                      await _saveLastUsedJob(selectedJob!.id);

                      final finalDescription =
                          description.isEmpty ? 'バイト' : description;

                      if (isEditing) {
                        eventToEdit.description = finalDescription;
                        eventToEdit.startTime = startTime;
                        eventToEdit.endTime = endTime;
                        eventToEdit.breakMinutes = breakMinutes;
                        eventToEdit.rate = selectedRate;
                        eventToEdit.jobName = selectedJob!.name;
                        eventToEdit.jobTransportation =
                            selectedJob!.transportation;
                        eventToEdit.job.value = selectedJob;

                        await _updateEvent(eventToEdit);
                      } else {
                        final event = EventModel(
                          date: _selectedDay!,
                          description: finalDescription,
                          startTime: startTime,
                          endTime: endTime,
                          type: 'job',
                          breakMinutes: breakMinutes,
                          rate: selectedRate,
                          jobName: selectedJob!.name,
                          jobTransportation: selectedJob!.transportation,
                        );

                        event.job.value = selectedJob;
                        await _addEvent(event);
                      }

                      Navigator.pop(context);
                    }
                  },
                  child: Text(isEditing ? '更新' : '追加'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ────── Task追加・編集 ──────
  void _showAddTaskEventDialog({EventModel? eventToEdit}) {
    final formKey = GlobalKey<FormState>();
    final isEditing = eventToEdit != null;

    String description = eventToEdit?.description ?? '';
    String? startTime = eventToEdit?.startTime.isNotEmpty == true
        ? eventToEdit!.startTime
        : null;
    String? endTime =
        eventToEdit?.endTime.isNotEmpty == true ? eventToEdit!.endTime : null;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateSB) {
            return AlertDialog(
              title: Text(isEditing ? 'その他の予定の編集' : 'その他の予定の追加'),
              content: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: '予定名'),
                        initialValue: description,
                        onChanged: (value) => description = value,
                        validator: (value) => value == null || value.isEmpty
                            ? '予定名を入力してください'
                            : null,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                final picked = await showTimePicker(
                                  context: context,
                                  initialTime:
                                      const TimeOfDay(hour: 10, minute: 0),
                                );
                                if (picked != null) {
                                  setStateSB(() => startTime =
                                      '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}');
                                }
                              },
                              child: AbsorbPointer(
                                child: TextFormField(
                                  decoration:
                                      const InputDecoration(labelText: '開始時間'),
                                  controller: TextEditingController(
                                      text: startTime ?? ''),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                final picked = await showTimePicker(
                                  context: context,
                                  initialTime:
                                      const TimeOfDay(hour: 12, minute: 0),
                                );
                                if (picked != null) {
                                  setStateSB(() => endTime =
                                      '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}');
                                }
                              },
                              child: AbsorbPointer(
                                child: TextFormField(
                                  decoration:
                                      const InputDecoration(labelText: '終了時間'),
                                  controller: TextEditingController(
                                      text: endTime ?? ''),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('キャンセル'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      if (isEditing) {
                        // 既存のイベントを更新
                        eventToEdit.description = description;
                        eventToEdit.startTime = startTime ?? '';
                        eventToEdit.endTime = endTime ?? '';

                        await _updateEvent(eventToEdit);
                      } else {
                        // 新規イベントを作成
                        final event = EventModel(
                          date: _selectedDay!,
                          description: description,
                          startTime: startTime ?? '',
                          endTime: endTime ?? '',
                          type: 'task',
                          breakMinutes: 0,
                        );

                        await _addEvent(event);
                      }

                      Navigator.pop(context);
                    }
                  },
                  child: Text(isEditing ? '更新' : '追加'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // 表示用の文字列を生成
  String _eventToDisplayString(EventModel event) {
    String time = '';
    if (event.startTime.isNotEmpty && event.endTime.isNotEmpty) {
      time = '${event.startTime}～${event.endTime}';
    } else {
      time = '時間未定';
    }

    String prefix = '';
    if (event.type == 'job') {
      // スナップショットから表示（Jobが削除されていても大丈夫）
      prefix = event.jobName ?? 'バイト先不明';
      if (event.rate != null) {
        // 表示も小数点以下を非表示に
        prefix +=
            '（${event.rate == event.rate!.toInt() ? event.rate!.toInt() : event.rate}円）';
      }
    }

    String desc = event.description.isNotEmpty && event.description != 'バイト'
        ? event.description
        : '';

    if (prefix.isNotEmpty && desc.isNotEmpty) {
      return '$time - $prefix: $desc';
    } else if (prefix.isNotEmpty) {
      return '$time - $prefix';
    } else {
      return '$time - $desc';
    }
  }

  // ────── 画面本体 ──────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAllData,
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar<EventModel>(
            daysOfWeekHeight: 24.0,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            eventLoader: _getEventsForDay,
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: customSwatch[400],
                borderRadius: BorderRadius.circular(10.0),
              ),
              formatButtonTextStyle: const TextStyle(color: Colors.white),
            ),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: customSwatch.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: customSwatch[700],
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: customSwatch[400],
                shape: BoxShape.circle,
              ),
            ),
            onDaySelected: _onDaySelected,
            onFormatChanged: _onFormatChanged,
            onPageChanged: _onPageChanged,
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                final normalizedDay = DateTime(day.year, day.month, day.day);
                final holiday = _holidaysCache[normalizedDay];

                if (holiday != null) {
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return null;
              },
              selectedBuilder: (context, day, focusedDay) {
                final normalizedDay = DateTime(day.year, day.month, day.day);
                final holiday = _holidaysCache[normalizedDay];

                return Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:
                        holiday != null ? Colors.red[700] : customSwatch[700],
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${day.day}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
              todayBuilder: (context, day, focusedDay) {
                final normalizedDay = DateTime(day.year, day.month, day.day);
                final holiday = _holidaysCache[normalizedDay];

                if (holiday != null) {
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(Icons.list, color: customSwatch[700]),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_selectedDay!.month}/${_selectedDay!.day}の予定',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      if (_holidaysCache[DateTime(_selectedDay!.year,
                              _selectedDay!.month, _selectedDay!.day)] !=
                          null)
                        Text(
                          _holidaysCache[DateTime(_selectedDay!.year,
                                  _selectedDay!.month, _selectedDay!.day)]!
                              .name,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _selectedEvents.isEmpty
                    ? const Center(child: Text('予定はありません。'))
                    : ListView.builder(
                        itemCount: _selectedEvents.length,
                        itemBuilder: (context, index) {
                          final event = _selectedEvents[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: customSwatch[200]!, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                title: Text(
                                  _eventToDisplayString(event),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: customSwatch[900],
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete,
                                      color: Colors.red[400]),
                                  onPressed: () => _deleteEvent(event),
                                ),
                                // カードをタップで編集
                                onTap: () {
                                  if (event.type == 'job') {
                                    _showAddJobEventDialog(eventToEdit: event);
                                  } else {
                                    _showAddTaskEventDialog(eventToEdit: event);
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showEventTypeDialog,
        backgroundColor: customSwatch,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
