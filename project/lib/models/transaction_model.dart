class TransactionModel {
  final int? id;
  final String type;
  final String category;
  final double amount;
  final String date;
  final String note;

  TransactionModel({
    this.id,
    required this.type,
    required this.category,
    required this.amount,
    required this.date,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'category': category,
      'amount': amount,
      'date': date,
      'note': note,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      type: map['type'],
      category: map['category'],
      amount: map['amount'],
      date: map['date'],
      note: map['note'],
    );
  }
}
