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

  await Hive.initFlutter();
  
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(ExpenseCategoryAdapter());

  final expenseBox = await Hive.openBox<Expense>('expenses');
  
  setupDI();
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ExpenseCubit>(
          create: (context) => ExpenseCubit(
            ExpenseRepository(expenseBox),
          ),
        ),
      ],
      child: const AppWidget(),
    ),
  );
}
