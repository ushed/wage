// lib/screens/salary_screen.dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:isar/isar.dart';
import '../theme.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import '../models/event.dart';
import '../models/monthly_adjustment.dart';

// ====================================================================
// 1. データモデル
// ====================================================================

class MonthlySalaryData {
  final double totalHours;
  final double totalSalary;
  final double adjustmentAmount;
  final String adjustmentReason;

  MonthlySalaryData({
    required this.totalHours,
    required this.totalSalary,
    this.adjustmentAmount = 0.0,
    this.adjustmentReason = '',
  });

  double get adjustedTotalSalary => totalSalary + adjustmentAmount;

  MonthlySalaryData copyWith({
    double? totalHours,
    double? totalSalary,
    double? adjustmentAmount,
    String? adjustmentReason,
  }) {
    return MonthlySalaryData(
      totalHours: totalHours ?? this.totalHours,
      totalSalary: totalSalary ?? this.totalSalary,
      adjustmentAmount: adjustmentAmount ?? this.adjustmentAmount,
      adjustmentReason: adjustmentReason ?? this.adjustmentReason,
    );
  }
}

class YearlySalaryData {
  final double totalHours;
  final double totalSalary;

  YearlySalaryData({required this.totalHours, required this.totalSalary});
}

// ====================================================================
// 2. SalaryScreen 本体
// ====================================================================

class SalaryScreen extends StatefulWidget {
  final Isar isar;
  const SalaryScreen({super.key, required this.isar});

  @override
  _SalaryScreenState createState() => _SalaryScreenState();
}

class _SalaryScreenState extends State<SalaryScreen>
    with WidgetsBindingObserver {
  final _currencyFormat = NumberFormat('#,##0', 'ja_JP');

  Map<String, MonthlySalaryData> _monthlyDataMap = {};
  Map<String, YearlySalaryData> _yearlyDataMap = {};

  String _selectedYear = DateTime.now().year.toString();
  bool _showingSalary = true;

  bool _isLoading = false;
  List<String> _availableYears = [];

  List<BarChartGroupData> _barGroups = [];
  double _maxY = 0;

  String _selectedYearMonth = '';
  String _selectedDisplayValue = '---';
  String _selectedMonthText = '月を選択';

  final double _barChartWidth = 550;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Isar監視して自動更新
    widget.isar.eventModels.watchLazy().listen((_) => _loadAllData());
    widget.isar.monthlyAdjustments.watchLazy().listen((_) => _loadAllData());

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

  // ====================================================================
  // 3. Isar操作ヘルパー
  // ====================================================================

  Future<MonthlyAdjustment?> _getAdjustment(String yearMonth) async {
    return await widget.isar.monthlyAdjustments
        .filter()
        .yearMonthEqualTo(yearMonth)
        .findFirst();
  }

  Future<void> _upsertAdjustment(MonthlyAdjustment adj) async {
    await widget.isar.writeTxn(() async {
      await widget.isar.monthlyAdjustments.put(adj);
    });
  }

  // ====================================================================
  // 4. データ集計
  // ====================================================================

  Future<void> _loadAllData() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    final allEvents = await widget.isar.eventModels.where().findAll();

    for (var event in allEvents) {
      await event.job.load();
    }

    Map<String, MonthlySalaryData> monthlyData = {};
    Set<String> years = {};

    for (var event in allEvents) {
      if (event.type != 'job' || event.rate == null) continue;

      final yearMonth =
          '${event.date.year}/${event.date.month.toString().padLeft(2, '0')}';
      years.add(event.date.year.toString());

      final hours = _calculateWorkHours(
        event.startTime,
        event.endTime,
        event.breakMinutes,
      );

      final salary = hours * event.rate!;
      final transportation = event.jobTransportation ?? 0.0;

      final adj = await _getAdjustment(yearMonth);

      if (monthlyData.containsKey(yearMonth)) {
        final existing = monthlyData[yearMonth]!;
        monthlyData[yearMonth] = MonthlySalaryData(
          totalHours: existing.totalHours + hours,
          totalSalary: existing.totalSalary + salary + transportation,
          adjustmentAmount: adj?.adjustmentAmount ?? existing.adjustmentAmount,
          adjustmentReason: adj?.adjustmentReason ?? existing.adjustmentReason,
        );
      } else {
        monthlyData[yearMonth] = MonthlySalaryData(
          totalHours: hours,
          totalSalary: salary + transportation,
          adjustmentAmount: adj?.adjustmentAmount ?? 0.0,
          adjustmentReason: adj?.adjustmentReason ?? '',
        );
      }
    }

    if (mounted) {
      setState(() {
        _monthlyDataMap = monthlyData;
        _availableYears = years.toList()..sort();
        if (_availableYears.isEmpty)
          _availableYears = [DateTime.now().year.toString()];
        if (!_availableYears.contains(_selectedYear))
          _selectedYear = _availableYears.last;

        _prepareBarGroups();
        _calculateYearlyData();

        if (_selectedYearMonth.isEmpty ||
            !_monthlyDataMap.containsKey(_selectedYearMonth)) {
          final now = DateTime.now();
          _selectedYearMonth =
              '${now.year}/${now.month.toString().padLeft(2, '0')}';
        }
        _calculateDisplayValues(_selectedYearMonth);

        _isLoading = false;
      });
    }
  }

  double _calculateWorkHours(
      String startTime, String endTime, int breakMinutes) {
    if (startTime.isEmpty || endTime.isEmpty) return 0.0;

    try {
      final start = _parseTime(startTime);
      final end = _parseTime(endTime);

      double totalMinutes = end >= start
          ? (end - start).toDouble()
          : (24 * 60 - start + end).toDouble();

      totalMinutes -= breakMinutes;
      return totalMinutes / 60.0;
    } catch (e) {
      return 0.0;
    }
  }

  int _parseTime(String time) {
    final parts = time.split(':');
    if (parts.length != 2) return 0;
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts[1]) ?? 0;
    return hour * 60 + minute;
  }

  void _calculateDisplayValues(String monthKey) {
    if (monthKey.isEmpty || !_monthlyDataMap.containsKey(monthKey)) {
      _selectedDisplayValue = '---';
      _selectedMonthText = '月を選択';
      return;
    }

    final data = _monthlyDataMap[monthKey]!;
    final month = int.tryParse(monthKey.substring(5)) ?? 0;

    final value = _showingSalary ? data.adjustedTotalSalary : data.totalHours;
    final valueText = _showingSalary
        ? '¥ ${_currencyFormat.format(value)}'
        : '${value.toStringAsFixed(1)} h';

    _selectedDisplayValue = valueText;
    _selectedMonthText = '${month}月分';
  }

  void _calculateYearlyData() {
    final currentYearData = _monthlyDataMap.entries
        .where((entry) => entry.key.startsWith(_selectedYear));

    double totalHours = 0;
    double totalAdjustedSalary = 0;

    for (var entry in currentYearData) {
      totalHours += entry.value.totalHours;
      totalAdjustedSalary += entry.value.adjustedTotalSalary;
    }

    _yearlyDataMap[_selectedYear] = YearlySalaryData(
      totalHours: totalHours,
      totalSalary: totalAdjustedSalary,
    );
  }

  void _prepareBarGroups() {
    final List<String> monthKeys = List.generate(
      12,
      (i) => '$_selectedYear/${(i + 1).toString().padLeft(2, '0')}',
    );

    _barGroups = monthKeys.asMap().entries.map((entry) {
      final int x = entry.key;
      final String monthKey = entry.value;

      final data = _monthlyDataMap[monthKey];
      final y = data != null
          ? (_showingSalary ? data.adjustedTotalSalary : data.totalHours)
          : 0.0;

      return BarChartGroupData(
        x: x,
        barRods: [
          BarChartRodData(
            toY: y,
            color: customSwatch[400],
            width: 16,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList();

    _maxY = _barGroups
        .map((g) => g.barRods.first.toY)
        .fold(100.0, (a, b) => max(a, b));
    _maxY = _maxY * 1.2;
  }

  // ====================================================================
  // 5. 月次詳細表示 & 補正ダイアログ
  // ====================================================================

  Widget _buildMonthlyDetail(String monthKey) {
    if (!_monthlyDataMap.containsKey(monthKey)) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'この月のデータがありません',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ),
      );
    }

    final MonthlySalaryData currentMonthData = _monthlyDataMap[monthKey]!;

    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$_selectedYearMonth の給与詳細',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: customSwatch[800],
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit_note, color: customSwatch[700], size: 30),
                tooltip: '給与を調整',
                onPressed: () =>
                    _showAdjustmentDialog(_selectedYearMonth, currentMonthData),
              ),
            ],
          ),
          const Divider(),
          _buildSalaryDetail(
            '合計勤務時間',
            '${currentMonthData.totalHours.toStringAsFixed(1)} 時間',
            Icons.access_time,
          ),
          const SizedBox(height: 10),
          _buildSalaryDetail(
            'システム算出額',
            '${_currencyFormat.format(currentMonthData.totalSalary)} 円',
            Icons.calculate_outlined,
          ),
          _buildSalaryDetail(
            '手動補正',
            '${currentMonthData.adjustmentAmount >= 0 ? '+' : '-'}${_currencyFormat.format(currentMonthData.adjustmentAmount.abs())} 円',
            currentMonthData.adjustmentAmount >= 0
                ? Icons.add_circle_outline
                : Icons.remove_circle_outline,
            currentMonthData.adjustmentAmount != 0.0
                ? (currentMonthData.adjustmentAmount > 0
                    ? Colors.green
                    : Colors.red)
                : null,
          ),
          if (currentMonthData.adjustmentReason.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 32.0, top: 4.0, bottom: 4.0),
              child: Text('理由: ${currentMonthData.adjustmentReason}',
                  style: const TextStyle(
                      fontSize: 14, fontStyle: FontStyle.italic)),
            ),
          const Divider(height: 20),
          _buildSalaryDetail(
            '最終合計額',
            '${_currencyFormat.format(currentMonthData.adjustedTotalSalary)} 円',
            Icons.paid,
            customSwatch[700],
          ),
        ],
      ),
    );
  }

  void _showAdjustmentDialog(
      String monthKey, MonthlySalaryData currentData) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (context) => SalaryAdjustmentDialog(
        currentAmount: currentData.adjustmentAmount,
        currentReason: currentData.adjustmentReason,
      ),
    );

    if (result != null) {
      final newAmount = result['amount'] as double;
      final newReason = result['reason'] as String;

      final adj = await _getAdjustment(monthKey) ?? MonthlyAdjustment()
        ..yearMonth = monthKey;
      adj.adjustmentAmount = newAmount;
      adj.adjustmentReason = newReason;
      await _upsertAdjustment(adj);

      setState(() {
        _monthlyDataMap[monthKey] = currentData.copyWith(
            adjustmentAmount: newAmount, adjustmentReason: newReason);
        _prepareBarGroups();
        _calculateYearlyData();
        _calculateDisplayValues(monthKey);
      });
    }
  }

  Widget _getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text = '${value.toInt() + 1}月';
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(text, style: style),
    );
  }

  // ====================================================================
  // 6. UIビルド
  // ====================================================================

  @override
  Widget build(BuildContext context) {
    final yearlyData = _yearlyDataMap[_selectedYear];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Salary - 給与管理'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedYear,
                dropdownColor: customSwatch[700],
                iconEnabledColor: Colors.white,
                items: _availableYears.map((String year) {
                  return DropdownMenuItem<String>(
                    value: year,
                    child: Text(
                      year,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedYear = newValue;
                      _prepareBarGroups();
                      _calculateYearlyData();
                      _selectedYearMonth = '';
                      _calculateDisplayValues(_selectedYearMonth);
                    });
                  }
                },
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  if (yearlyData != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${_selectedYear}年の年間集計',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: customSwatch[800],
                                ),
                              ),
                              const Divider(),
                              _buildSalaryDetail(
                                '合計勤務時間',
                                '${yearlyData.totalHours.toStringAsFixed(1)} 時間',
                                Icons.access_time_filled,
                              ),
                              const SizedBox(height: 10),
                              _buildSalaryDetail(
                                '合計収入',
                                '${_currencyFormat.format(yearlyData.totalSalary)} 円',
                                Icons.monetization_on,
                                customSwatch[700],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  _selectedMonthText,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: customSwatch[800],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _selectedDisplayValue,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                      color: customSwatch[600],
                                    ),
                                    textAlign: TextAlign.right,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 10, thickness: 1.5),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.end, // 右端に揃える
                              children: [
                                IconButton(
                                  icon: Icon(
                                    _showingSalary
                                        ? Icons.access_time
                                        : Icons.attach_money,
                                    color: customSwatch[500],
                                  ),
                                  tooltip: _showingSalary
                                      ? '勤務時間表示に切り替える'
                                      : '給与額表示に切り替える',
                                  onPressed: () {
                                    setState(() {
                                      _showingSalary = !_showingSalary;
                                      _prepareBarGroups();
                                      _calculateDisplayValues(
                                          _selectedYearMonth);
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                width: _barChartWidth,
                                height: 250,
                                child: BarChart(
                                  BarChartData(
                                    barTouchData: BarTouchData(
                                      enabled: true,
                                      touchCallback: (event, response) {
                                        if (response?.spot != null &&
                                            event is FlTapUpEvent) {
                                          final clickedIndex = response!
                                              .spot!.touchedBarGroupIndex;
                                          final month = clickedIndex + 1;
                                          final monthKey =
                                              '$_selectedYear/${month.toString().padLeft(2, '0')}';

                                          setState(() {
                                            _selectedYearMonth = monthKey;
                                            _prepareBarGroups();
                                            _calculateDisplayValues(monthKey);
                                          });
                                        }
                                      },
                                      touchTooltipData: BarTouchTooltipData(
                                          getTooltipItem: (group, groupIndex,
                                                  rod, rodIndex) =>
                                              null),
                                    ),
                                    alignment: BarChartAlignment.spaceAround,
                                    titlesData: FlTitlesData(
                                      show: true,
                                      rightTitles: const AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false)),
                                      topTitles: const AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false)),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: _getTitles,
                                          reservedSize: 30,
                                        ),
                                      ),
                                      leftTitles: const AxisTitles(
                                          sideTitles: SideTitles(
                                              showTitles: false,
                                              reservedSize: 0)),
                                    ),
                                    gridData: FlGridData(
                                      show: true,
                                      drawVerticalLine: false,
                                      getDrawingHorizontalLine: (value) =>
                                          FlLine(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              strokeWidth: 0.5),
                                    ),
                                    borderData: FlBorderData(
                                      show: true,
                                      border: const Border(
                                        left: BorderSide(
                                            color: Colors.transparent),
                                        bottom: BorderSide(
                                            color: Colors.black, width: 1),
                                      ),
                                    ),
                                    barGroups: _barGroups,
                                    maxY: _maxY,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (_selectedYearMonth.isNotEmpty)
                    _buildMonthlyDetail(_selectedYearMonth),
                ],
              ),
            ),
    );
  }

  Widget _buildSalaryDetail(String label, String value, IconData icon,
      [Color? valueColor]) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        const SizedBox(width: 8),
        Text('$label: ',
            style: const TextStyle(fontSize: 16, color: Colors.black87)),
        Text(value,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: valueColor ?? Colors.black)),
      ],
    );
  }
}

// ====================================================================
// 7. SalaryAdjustmentDialog
// ====================================================================

class SalaryAdjustmentDialog extends StatefulWidget {
  final double currentAmount;
  final String currentReason;

  const SalaryAdjustmentDialog({
    super.key,
    required this.currentAmount,
    required this.currentReason,
  });

  @override
  State<SalaryAdjustmentDialog> createState() => _SalaryAdjustmentDialogState();
}

class _SalaryAdjustmentDialogState extends State<SalaryAdjustmentDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _amountController;
  late TextEditingController _reasonController;

  @override
  void initState() {
    super.initState();
    _amountController =
        TextEditingController(text: widget.currentAmount.toStringAsFixed(0));
    _reasonController = TextEditingController(text: widget.currentReason);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final normalized =
          _amountController.text.replaceAll('−', '-'); // 全角マイナス対応
      final newAmount = double.tryParse(normalized) ?? 0.0;
      final newReason = _reasonController.text.trim();

      Navigator.of(context).pop({'amount': newAmount, 'reason': newReason});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('給与の手動補正', style: TextStyle(color: customSwatch[800])),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: '補正額 (±)',
                  hintText: '例: 500 または -350',
                  prefixText: '¥ ',
                  border: OutlineInputBorder(),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(signed: true),
                validator: (value) {
                  if (value == null || value.isEmpty) return '補正額を入力してください。';
                  final normalized = value.replaceAll('−', '-'); // 全角マイナス対応
                  if (double.tryParse(normalized) == null)
                    return '有効な数値を入力してください。';
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _reasonController,
                decoration: const InputDecoration(
                  labelText: '補正理由 (任意)',
                  hintText: '例: 端数切捨て、特別手当',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(null),
            child: const Text('キャンセル')),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('保存'),
          style: ElevatedButton.styleFrom(
              backgroundColor: customSwatch[500],
              foregroundColor: Colors.white),
        ),
      ],
    );
  }
}
