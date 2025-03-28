import 'package:hive/hive.dart';
import '../core/expense_model.dart';

class ExpenseRepository {
  final Box<Expense> _expenseBox;

  ExpenseRepository(this._expenseBox);

  Future<void> addExpense(Expense expense) async {
    await _expenseBox.put(expense.id, expense);
  }

  List<Expense> getAllExpenses() {
    return _expenseBox.values.toList();
  }

  Future<void> deleteExpense(String id) async {
    await _expenseBox.delete(id);
  }
}
