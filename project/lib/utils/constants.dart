class AppConstants {
  // Database table names
  static const String transactionTable = 'transactions';
  static const String debtTable = 'debts';
  static const String userTable = 'users';

  // Transaction types
  static const String incomeType = 'Income';
  static const String expenseType = 'Expense';

  // Categories for income and expenses
  static const List<String> incomeCategories = [
    'Refund',
    'Extra Money',
    'Salary',
    'Free Money',
    'Business Income',
    'Borrowed Money',
  ];

  static const List<String> expenseCategories = [
    'Food',
    'Travel',
    'Accommodation',
    'Supplies',
    'Medical',
  ];

  // Debt categories (similar to expense categories)
  static const List<String> debtCategories = [
    'Food',
    'Travel',
    'Accommodation',
    'Supplies',
    'Medical',
  ];

  // Default currency symbol
  static const String currencySymbol = '\$';
}
