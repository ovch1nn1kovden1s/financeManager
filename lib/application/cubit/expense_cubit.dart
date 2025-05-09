import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/expense_model.dart';
import '../../core/expense_repository.dart';

abstract class ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<Expense> expenses;
  final Map<String, double> categoryMap;

  ExpenseLoaded(this.expenses, this.categoryMap);
}

class ExpenseError extends ExpenseState {
  final String message;

  ExpenseError(this.message);
}

class ExpenseCubit extends Cubit<ExpenseState> {
  final ExpenseRepository _repository;

  ExpenseCubit(this._repository) : super(ExpenseLoading());

  Future<void> loadExpenses() async {
    try {
      emit(ExpenseLoading());
      final expenses = _repository.getAllExpenses();

      final categoryMap = _generateCategoryMap(expenses);

      emit(ExpenseLoaded(expenses, categoryMap));
    } catch (e) {
      emit(ExpenseError('Не удалось загрузить траты: ${e.toString()}'));
    }
  }

  Future<void> addExpense(Expense expense) async {
    try {
      await _repository.addExpense(expense);
      await loadExpenses();
    } catch (e) {
      emit(ExpenseError('Не удалось добавить трату: ${e.toString()}'));
    }
  }

  Future<void> deleteExpense(String id) async {
    try {
      await _repository.deleteExpense(id);
      await loadExpenses();
    } catch (e) {
      emit(ExpenseError('Не удалось удалить трату: ${e.toString()}'));
    }
  }

  Map<String, double> _generateCategoryMap(List<Expense> expenses) {
    final categoryMap = <String, double>{};
    for (var expense in expenses) {
      categoryMap.update(
        expense.category.name,
        (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }
    return categoryMap;
  }
}