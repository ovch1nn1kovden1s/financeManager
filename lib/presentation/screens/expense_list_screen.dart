import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/cubit/expense_cubit.dart';
import 'package:go_router/go_router.dart';
import '../../core/expense_model.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  _ExpenseListScreenState createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ExpenseCubit>().loadExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список трат'),
      ),
      body: BlocBuilder<ExpenseCubit, ExpenseState>(
        builder: (context, state) {
          if (state is ExpenseLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExpenseLoaded) {
            if (state.categoryMap.isEmpty) {
              return const Center(child: Text('Список трат пуст'));
            }

            return ListView(
              children: state.categoryMap.entries.map((entry) {
                final categoryName = entry.key;
                final totalAmount = entry.value;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => _navigateToCategory(context, categoryName, state.expenses),
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

  void _navigateToCategory(BuildContext context, String categoryName, List<Expense> expenses) {
    context.go('/category-expenses/$categoryName', extra: expenses);
  }
}