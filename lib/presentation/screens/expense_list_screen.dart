import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/cubit/expense_cubit.dart';
import 'package:go_router/go_router.dart';
import '../../core/expense_model.dart';

class ExpenseListScreen extends StatelessWidget {
  const ExpenseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            final categoryMap = <String, double>{};
            for (var expense in state.expenses) {
              categoryMap.update(
                expense.category.name,
                (value) => value + expense.amount,
                ifAbsent: () => expense.amount,
              );
            }

            return ListView(
              children: categoryMap.entries.map((entry) {
                final categoryName = entry.key;
                final totalAmount = entry.value;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      context.go(
                        '/category-expenses/$categoryName',
                        extra: state.expenses,
                      );
                    },
                    child: ListTile(
                      title: Text(categoryName),
                      trailing: Text('Сумма: $totalAmount'),
                    ),
                  ),
                );
              }).toList(),
            );
          } else if (state is ExpenseError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Ошибка загрузки'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/add-expense');
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}