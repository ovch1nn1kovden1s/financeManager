import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/cubit/expense_cubit.dart';
import '../../core/di_container.dart';

class AddExpenseScreen extends StatefulWidget {
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Добавить трату')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Название'),
            ),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Категория'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Сумма'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (_) => getIt<ExpenseCubit>(), // Передаем ExpenseCubit из GetIt
                      child: AddExpenseScreen(),
                    ),
                  ),
                );
              },
              child: Text('Добавить трату'),
            )
          ],
        ),
      ),
    );
  }
}