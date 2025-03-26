import 'package:flutter/material.dart';
import 'package:test/core/expense_model.dart';
import 'core/di_container.dart';
import 'presentation/app_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/cubit/expense_cubit.dart';
import '../../core/expense_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация Hive
  await Hive.initFlutter();
  
  // Регистрация адаптера
  Hive.registerAdapter(ExpenseAdapter());
  
  // Открытие Box
  final expenseBox = await Hive.openBox<Expense>('expenses');

  if (expenseBox.isEmpty) {
    await expenseBox.put(
      '1',
      Expense(id: '1', name: 'Test Expense', category: 'cat', amount: 100.0, date: DateTime.now()),
    );
  }
  
  // Настройка DI
  setupDI();
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ExpenseCubit>(
          create: (context) => ExpenseCubit(
            ExpenseRepository(expenseBox), // Передаём объект Box<Expense>
          ),
        ),
      ],
      child: const AppWidget(),
    ),
  );
}
