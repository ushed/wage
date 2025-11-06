// lib/screens/works_screen.dart

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../theme.dart';
import '../models/job.dart';

// ====================================================================
// 1. WorksScreen 本体
// ====================================================================

class WorksScreen extends StatefulWidget {
  final Isar isar; // Isar を main.dart から受け取る
  const WorksScreen({super.key, required this.isar});

  @override
  State<WorksScreen> createState() => _WorksScreenState();
}

class _WorksScreenState extends State<WorksScreen> {
  late Future<List<Job>> _jobsFuture;
  late final Isar isar;

  @override
  void initState() {
    super.initState();
    isar = widget.isar; // main.dart から渡された Isar を使用
    _loadJobs();
  }

  void _loadJobs() {
    _jobsFuture = isar.jobs.where().findAll();
  }

  Future<void> _addJob(Job job) async {
    await isar.writeTxn(() async {
      await isar.jobs.put(job);
    });
    _loadJobs();
    setState(() {});
  }

  Future<void> _updateJob(Job job) async {
    await isar.writeTxn(() async {
      await isar.jobs.put(job);
    });
    _loadJobs();
    setState(() {});
  }

  Future<void> _deleteJob(Job job) async {
    // 🟡 削除確認ダイアログを表示
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('削除確認'),
        content: Text('「${job.name}」を削除してもよろしいですか？\n'
            '※ このバイト先に紐づく勤務記録がある場合は注意してください。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('キャンセル'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('削除'),
          ),
        ],
      ),
    );

    // キャンセルされた場合は削除せず終了
    if (confirmed != true) return;

    // 確認後に削除実行
    await isar.writeTxn(() async {
      await isar.jobs.delete(job.id);
    });

    _loadJobs();
    setState(() {});
  }

  void _showJobFormDialog({Job? jobToEdit}) async {
    final bool isEditing = jobToEdit != null;

    final newOrUpdatedJob = await showDialog<Job>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AddJobDialog(initialJob: jobToEdit),
    );

    if (newOrUpdatedJob != null) {
      if (isEditing) {
        await _updateJob(newOrUpdatedJob);
      } else {
        await _addJob(newOrUpdatedJob);
      }
    }
  }

  Widget _buildJobItem(Job job) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: customSwatch[200]!, width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading:
            Icon(Icons.business_center, color: customSwatch[700], size: 30),
        title: Text(
          job.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: customSwatch[900],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('時給パターン: ${job.displayRate}円'),
            Text('交通費: ${job.transportation.toStringAsFixed(0)}円/日'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red[400]),
          onPressed: () => _deleteJob(job),
        ),
        onTap: () => _showJobFormDialog(jobToEdit: job),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Works - バイト先管理'),
      ),
      body: FutureBuilder<List<Job>>(
        future: _jobsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('エラー: ${snapshot.error}'));
          }

          final jobs = snapshot.data ?? [];

          if (jobs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.work_outline, size: 80, color: customSwatch[400]),
                  const SizedBox(height: 20),
                  Text(
                    'バイト先が登録されていません',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: customSwatch[800],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '右下の追加ボタンからバイト先を登録しましょう。',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '登録済みのバイト先 (${jobs.length}件)',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: customSwatch[800],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: jobs.length,
                    itemBuilder: (context, index) {
                      return _buildJobItem(jobs[index]);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showJobFormDialog(),
        child: const Icon(Icons.add),
        backgroundColor: customSwatch,
        foregroundColor: Colors.white,
      ),
    );
  }
}

// ====================================================================
// 2. AddJobDialog
// ====================================================================

class AddJobDialog extends StatefulWidget {
  final Job? initialJob;
  const AddJobDialog({super.key, this.initialJob});

  @override
  State<AddJobDialog> createState() => _AddJobDialogState();
}

class _AddJobDialogState extends State<AddJobDialog> {
  final formKey = GlobalKey<FormState>();
  late String _jobName;
  final List<TextEditingController> _rateControllers = [];
  late String _transportation;

  @override
  void initState() {
    super.initState();
    final initialJob = widget.initialJob;
    if (initialJob != null) {
      _jobName = initialJob.name;
      _transportation = initialJob.transportation.toStringAsFixed(0);
      for (var rate in initialJob.rates) {
        _rateControllers
            .add(TextEditingController(text: rate.toStringAsFixed(0)));
      }
    } else {
      _jobName = '';
      _transportation = '0';
      _rateControllers.add(TextEditingController(text: '1000'));
    }
  }

  @override
  void dispose() {
    for (var c in _rateControllers) c.dispose();
    super.dispose();
  }

  void _addRateField() {
    setState(() {
      _rateControllers.add(TextEditingController());
    });
  }

  void _removeRateField(int index, TextEditingController controller) {
    controller.dispose();
    setState(() {
      _rateControllers.removeAt(index);
    });
  }

  void _submitForm() {
    if (formKey.currentState!.validate()) {
      final rates = _rateControllers
          .map((c) => double.tryParse(c.text.trim()))
          .whereType<double>()
          .toList();

      if (rates.isEmpty) return;

      final trans = double.parse(_transportation);

      final newJob = (widget.initialJob ??
              Job(name: _jobName, rates: [], transportation: 0.0))
          .copyWith(name: _jobName, rates: rates, transportation: trans);

      Navigator.of(context).pop(newJob);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.initialJob != null;
    final title = isEditing ? 'バイト先を編集' : '新しいバイト先を追加';
    final submitText = isEditing ? '更新' : '追加';

    return AlertDialog(
      title: Text(title, style: TextStyle(color: customSwatch[800])),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: isEditing ? widget.initialJob!.name : null,
                decoration: const InputDecoration(
                  labelText: 'バイト先名',
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) => _jobName = v,
                validator: (v) =>
                    v == null || v.isEmpty ? 'バイト先名を入力してください' : null,
                enabled: !isEditing, // ←⭐ 編集モードでは入力不可に
                style: TextStyle(
                  color:
                      isEditing ? Colors.grey[700] : Colors.black, // ←⭐ 少しグレー表示
                ),
              ),
              const SizedBox(height: 15),
              Text('時給パターン (円):',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: customSwatch[700])),
              ..._rateControllers.asMap().entries.map((e) {
                final index = e.key;
                final controller = e.value;
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          key: ValueKey('rate_input_$index'),
                          controller: controller,
                          decoration: InputDecoration(
                            labelText: '時給 ${index + 1}',
                            hintText: '例: 1100',
                            border: const OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return index == 0
                                  ? '基本時給を入力してください'
                                  : '値を入力するか削除してください';
                            }
                            if (double.tryParse(v) == null)
                              return '有効な数値を入力してください';
                            return null;
                          },
                        ),
                      ),
                      if (index > 0)
                        IconButton(
                          icon:
                              Icon(Icons.remove_circle, color: Colors.red[400]),
                          onPressed: () => _removeRateField(index, controller),
                        ),
                    ],
                  ),
                );
              }),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('時給を追加'),
                  onPressed: _addRateField,
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                initialValue: isEditing
                    ? widget.initialJob!.transportation.toStringAsFixed(0)
                    : _transportation,
                decoration: const InputDecoration(
                  labelText: '1日あたりの交通費 (円/往復)',
                  hintText: '例: 450',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (v) => _transportation = v,
                validator: (v) {
                  if (v == null || v.isEmpty) return '交通費を入力してください';
                  if (double.tryParse(v) == null) return '有効な数値を入力してください';
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('キャンセル')),
        ElevatedButton(
            onPressed: _submitForm,
            child: Text(submitText),
            style: ElevatedButton.styleFrom(
                backgroundColor: customSwatch[500],
                foregroundColor: Colors.white)),
      ],
    );
  }
}
