import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/cubit/expense_cubit.dart';

class ExpenseListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Загружаем траты при открытии экрана
    context.read<ExpenseCubit>().loadExpenses();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Список трат'),
      ),
      body: BlocBuilder<ExpenseCubit, ExpenseState>(
        builder: (context, state) {
          if (state is ExpenseLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExpenseLoaded) {
            if (state.expenses.isEmpty) {
              return const Center(child: Text('Список трат пуст'));
            }
            return ListView.builder(
              itemCount: state.expenses.length,
              itemBuilder: (context, index) {
                final expense = state.expenses[index];
                return ListTile(
                  title: Text(expense.name),
                  subtitle: Text('${expense.category} - ${expense.amount}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => context.read<ExpenseCubit>().deleteExpense(expense.id),
                  ),
                );
              },
            );
          } else if (state is ExpenseError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Ошибка загрузки'));
          }
        },
      ),
    );
  }
}
