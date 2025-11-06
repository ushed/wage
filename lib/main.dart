// lib/main.dart

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import './theme.dart' as theme;
import './screens/home_screen.dart' as home;
import './screens/schedule_screen.dart' as schedule;
import './screens/salary_screen.dart' as salary;
import './screens/works_screen.dart' as works;
import 'models/job.dart';
import 'models/event.dart';
import 'models/monthly_adjustment.dart';
import 'models/holiday.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  // EventModelSchemaを追加
  final isar = await Isar.open(
    [
      JobSchema,
      EventModelSchema,
      MonthlyAdjustmentSchema,
      HolidaySchema,
    ],
    directory: dir.path,
  );

  runApp(MyApp(isar: isar));
}

class MyApp extends StatefulWidget {
  final Isar isar;
  const MyApp({super.key, required this.isar});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    // 各画面に必要なデータを渡す
    _screens = [
      home.HomeScreen(isar: widget.isar), // Isarを渡す
      schedule.ScheduleScreen(isar: widget.isar),
      salary.SalaryScreen(isar: widget.isar),
      works.WorksScreen(isar: widget.isar),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'アルバイト管理アプリ',
      theme: theme.appTheme,
      home: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Schedule',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: 'Salary',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work_outline),
              label: 'Works',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: theme.customSwatch,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
