import 'package:flutter/material.dart';
import '../../core/expense_model.dart';
import 'package:go_router/go_router.dart';
import '../../application/cubit/expense_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryExpensesScreen extends StatelessWidget {
  final String categoryName;
  final List<Expense> expenses;

  const CategoryExpensesScreen({
    super.key,
    required this.categoryName,
    required this.expenses,
  });

 @override
Widget build(BuildContext context) {
  return BlocBuilder<ExpenseCubit, ExpenseState>(
    builder: (context, state) {
      if (state is ExpenseLoading) {
         return const Center(child: CircularProgressIndicator());
      } else if (state is ExpenseLoaded) {
        final categoryExpenses = state.expenses
            .where((e) => e.category.name == categoryName)
            .toList();

        return Scaffold(
          appBar: AppBar(
            title: Text(categoryName),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.go('/expense-list');
              },
            ),
          ),
          body: categoryExpenses.isEmpty
              ? const Center(child: Text('Нет трат в этой категории'))
              : ListView.builder(
                  itemCount: categoryExpenses.length,
                  itemBuilder: (context, index) {
                    final expense = categoryExpenses[index];
                    return ListTile(
                      title: Text(expense.name),
                      subtitle: Text('${expense.amount}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () =>
                            context.read<ExpenseCubit>().deleteExpense(expense.id),
                      ),
                    );
                  },
                ),
        );
      }
      return const Center(child: CircularProgressIndicator());
    },
  );
  }
}