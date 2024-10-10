import 'package:flutter/material.dart';
import '../services/db_helper.dart';
import 'category_transactions_screen.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final DBHelper _dbHelper = DBHelper();
  List<String> _incomeCategories = [];
  List<String> _expenseCategories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    _incomeCategories = [
      'Salary',
      'Refund',
      'Business Income',
      'Investments',
      'Freelance Work'
    ];
    _expenseCategories = [
      'Food',
      'Travel',
      'Accommodation',
      'Utilities',
      'Medical',
      'Shopping'
    ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCategorySection(
                'Income Categories',
                _incomeCategories,
                'Income',
                theme,
              ),
              SizedBox(height: 16),
              _buildCategorySection(
                'Expense Categories',
                _expenseCategories,
                'Expense',
                theme,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection(
      String title, List<String> categories, String type, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: theme.brightness == Brightness.light
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.titleLarge?.color,
            ),
          ),
          SizedBox(height: 8),
          categories.isEmpty
              ? Text(
                  'No data available',
                  style: TextStyle(color: theme.textTheme.bodyMedium?.color),
                )
              : Column(
                  children: categories
                      .map((category) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryTransactionsScreen(
                                    category: category,
                                    type: type,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.category,
                                    size: 20,
                                    color: theme.iconTheme.color,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      category,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: theme.textTheme.bodyMedium?.color,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
        ],
      ),
    );
  }
}
