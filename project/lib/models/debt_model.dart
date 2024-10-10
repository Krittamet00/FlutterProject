class DebtModel {
  final int? id;
  final String name;
  final String category;
  final double amount;
  final String date;
  final String note;

  DebtModel({
    this.id,
    required this.name,
    required this.category,
    required this.amount,
    required this.date,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'amount': amount,
      'date': date,
      'note': note,
    };
  }

  factory DebtModel.fromMap(Map<String, dynamic> map) {
    return DebtModel(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      amount: map['amount'],
      date: map['date'],
      note: map['note'],
    );
  }
}
