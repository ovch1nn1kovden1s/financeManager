class Expense {
  final String id;
  final String name;
  final String category;
  final double amount;
  final DateTime date;

  Expense({
    required this.id,
    required this.name,
    required this.category,
    required this.amount,
    required this.date,
  });

  // Метод для преобразования в Map (для хранения в Hive)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  // Метод для создания объекта из Map
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
    );
  }
}
