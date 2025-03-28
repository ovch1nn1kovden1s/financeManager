import 'package:hive/hive.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 1)
enum ExpenseCategory {
  @HiveField(0)
  food,

  @HiveField(1)
  transport,

  @HiveField(2)
  entertainment,

  @HiveField(3)
  health,

  @HiveField(4)
  other,
}

extension ExpenseCategoryExtension on ExpenseCategory {
  String get name {
    switch (this) {
      case ExpenseCategory.food:
        return 'Еда';
      case ExpenseCategory.transport:
        return 'Транспорт';
      case ExpenseCategory.entertainment:
        return 'Развлечения';
      case ExpenseCategory.health:
        return 'Здоровье';
      case ExpenseCategory.other:
        return 'Другое';
    }
  }
}

@HiveType(typeId: 0)
class Expense {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  ExpenseCategory category;

  @HiveField(3)
  double amount;

  @HiveField(4)
  DateTime date;

  Expense({
    required this.id,
    required this.name,
    required this.category,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category.name,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      name: map['name'],
      category: ExpenseCategory.values.firstWhere(
        (e) => e.name == map['category'],
        orElse: () => ExpenseCategory.other,
      ),
      amount: map['amount'],
      date: DateTime.parse(map['date']),
    );
  }
}
