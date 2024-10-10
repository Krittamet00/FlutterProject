import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/db_helper.dart';

class SummaryScreen extends StatefulWidget {
  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final DBHelper _dbHelper = DBHelper();
  double _totalIncome = 0.0;
  double _totalExpenses = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchSummaryData();
  }

  Future<void> _fetchSummaryData() async {
    final totalIncome = await _dbHelper.getTotalIncome();
    final totalExpenses = await _dbHelper.getTotalExpenses();

    setState(() {
      _totalIncome = totalIncome;
      _totalExpenses = totalExpenses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInfoBox(),
            SizedBox(height: 16),
            Expanded(
              child: _buildPieChart(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox() {
    // Check if the current theme is dark or light
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDarkTheme ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: isDarkTheme ? Colors.black.withOpacity(0.2) : Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Summary',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Total Income: \$${_totalIncome.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          Text(
            'Total Expenses: \$${_totalExpenses.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              _buildColorIndicator(Colors.green, 'Income'),
              SizedBox(width: 16),
              _buildColorIndicator(Colors.red, 'Expenses'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorIndicator(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(width: 8),
        Text(label, style: TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildPieChart() {
    double total = _totalIncome + _totalExpenses;
    if (total == 0) {
      // Handle case when both income and expenses are zero
      return Center(
        child: Text('No data available to display.'),
      );
    }

    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: _totalIncome,
            title: '${((_totalIncome / total) * 100).toStringAsFixed(1)}%',
            color: Colors.green,
            radius: 100,
          ),
          PieChartSectionData(
            value: _totalExpenses,
            title: '${((_totalExpenses / total) * 100).toStringAsFixed(1)}%',
            color: Colors.red,
            radius: 100,
          ),
        ],
        sectionsSpace: 2,
        centerSpaceRadius: 40,
      ),
    );
  }
}
