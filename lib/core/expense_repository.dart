import 'package:hive/hive.dart';
import '../core/expense_model.dart';

class ExpenseRepository {
  final Box<Expense> _expenseBox;

  ExpenseRepository(this._expenseBox);

  // Добавить трату
  Future<void> addExpense(Expense expense) async {
    await _expenseBox.put(expense.id, expense);
  }

  // Получить все траты
  List<Expense> getAllExpenses() {
    return _expenseBox.values.toList();
  }

  // Удалить трату
  Future<void> deleteExpense(String id) async {
    await _expenseBox.delete(id);
  }
}
