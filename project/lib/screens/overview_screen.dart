import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../services/db_helper.dart';
import '../widgets/info_box.dart';

class OverviewScreen extends StatefulWidget {
  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  final DBHelper _dbHelper = DBHelper();
  DateTime _selectedDate = DateTime.now();
  double _totalIncome = 0.0;
  double _totalExpenses = 0.0;
  double _totalDebts = 0.0;
  double _dailyIncome = 0.0;
  double _dailyExpenses = 0.0;
  double _weeklyIncome = 0.0;
  double _weeklyExpenses = 0.0;
  double _monthlyIncome = 0.0;
  double _monthlyExpenses = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _fetchSummaries(_selectedDate);
  }

  Future<void> _fetchData() async {
    final totalIncome = await _dbHelper.getTotalIncome();
    final totalExpenses = await _dbHelper.getTotalExpenses();
    final totalDebts = await _dbHelper.getTotalDebts();

    setState(() {
      _totalIncome = totalIncome;
      _totalExpenses = totalExpenses;
      _totalDebts = totalDebts;
    });
  }

  Future<void> _fetchSummaries(DateTime date) async {
    final dailySummary = await _dbHelper.getDailySummary(date);
    final weeklySummary = await _dbHelper.getWeeklySummary(date);
    final monthlySummary = await _dbHelper.getMonthlySummary(date);

    setState(() {
      _dailyIncome = dailySummary['income']!;
      _dailyExpenses = dailySummary['expense']!;
      _weeklyIncome = weeklySummary['income']!;
      _weeklyExpenses = weeklySummary['expense']!;
      _monthlyIncome = monthlySummary['income']!;
      _monthlyExpenses = monthlySummary['expense']!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double totalBalance = _totalIncome - _totalExpenses - _totalDebts;
    final double dailyBalance = _dailyIncome - _dailyExpenses;
    final double weeklyBalance = _weeklyIncome - _weeklyExpenses;
    final double monthlyBalance = _monthlyIncome - _monthlyExpenses;

    return Scaffold(
      appBar: AppBar(title: Text('Overview')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: InfoBox(
                  title: 'Summary',
                  content: 'Total Income: \$${_totalIncome.toStringAsFixed(2)}\n'
                      'Total Expense: \$${_totalExpenses.toStringAsFixed(2)}\n'
                      'Total Debts: \$${_totalDebts.toStringAsFixed(2)}\n'
                      'Balance: \$${totalBalance.toStringAsFixed(2)}',
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: InfoBox(
                  title: 'Daily Summary',
                  content: 'Income: \$${_dailyIncome.toStringAsFixed(2)}\n'
                      'Expense: \$${_dailyExpenses.toStringAsFixed(2)}\n'
                      'Balance: \$${dailyBalance.toStringAsFixed(2)}',
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: InfoBox(
                  title: 'Weekly Summary',
                  content: 'Income: \$${_weeklyIncome.toStringAsFixed(2)}\n'
                      'Expense: \$${_weeklyExpenses.toStringAsFixed(2)}\n'
                      'Balance: \$${weeklyBalance.toStringAsFixed(2)}',
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: InfoBox(
                  title: 'Monthly Summary',
                  content: 'Income: \$${_monthlyIncome.toStringAsFixed(2)}\n'
                      'Expense: \$${_monthlyExpenses.toStringAsFixed(2)}\n'
                      'Balance: \$${monthlyBalance.toStringAsFixed(2)}',
                ),
              ),
              SizedBox(height: 16),
              _buildCalendar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      focusedDay: _selectedDate,
      firstDay: DateTime(2000),
      lastDay: DateTime(2100),
      calendarFormat: CalendarFormat.month,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDate, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDate = selectedDay;
        });
        _fetchSummaries(selectedDay);
        _showDailySummaryDialog(selectedDay);
      },
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Future<void> _showDailySummaryDialog(DateTime date) async {
    final summary = await _dbHelper.getDailySummary(date);
    final dailyIncome = summary['income']!;
    final dailyExpenses = summary['expense']!;
    final dailyBalance = dailyIncome - dailyExpenses;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Summary for ${date.toLocal().toString().split(' ')[0]}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Income: \$${dailyIncome.toStringAsFixed(2)}'),
              Text('Expense: \$${dailyExpenses.toStringAsFixed(2)}'),
              Divider(),
              Text(
                'Balance: \$${dailyBalance.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
