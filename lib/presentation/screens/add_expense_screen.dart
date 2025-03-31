import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/cubit/expense_cubit.dart';
import '../../core/expense_model.dart';
import 'package:go_router/go_router.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  ExpenseCategory? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить трату'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/expense-list');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Название'),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<ExpenseCategory>(
              value: _selectedCategory,
              decoration: InputDecoration(labelText: 'Категория'),
              items: ExpenseCategory.values.map((category) {
                return DropdownMenuItem<ExpenseCategory>(
                  value: category,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Сумма'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text;
                final category = _selectedCategory;
                final amount = double.tryParse(_amountController.text);

                if (name.isNotEmpty && category != null && amount != null) {
                  context.read<ExpenseCubit>().addExpense(
                    Expense(
                      id: DateTime.now().toString(),
                      name: name,
                      category: category,
                      amount: amount,
                      date: DateTime.now(),
                    ),
                  );
                  context.go('/expense-list');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Пожалуйста, заполните все поля корректно')),
                  );
                }
              },
              child: Text('Добавить трату'),
            )
          ],
        ),
      ),
    );
  }
}