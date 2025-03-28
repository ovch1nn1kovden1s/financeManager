import 'package:get_it/get_it.dart';
import '../application/cubit/app_cubit.dart';
import 'package:hive/hive.dart';
import '../core/expense_repository.dart';
import '../application/cubit/expense_cubit.dart';
import '../core/expense_model.dart';

final getIt = GetIt.instance;

void setupDI() {
  getIt.registerLazySingleton<AppCubit>(() => AppCubit());

  final expenseBox = Hive.box<Expense>('expenses');
  getIt.registerSingleton<ExpenseRepository>(ExpenseRepository(expenseBox));
  getIt.registerFactory(() => ExpenseCubit(getIt<ExpenseRepository>()));
}
