import 'package:go_router/go_router.dart';
import 'screens/screen1.dart';
import 'screens/screen2.dart';
import 'screens/add_expense_screen.dart';
import 'screens/expense_list_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Screen1(),
    ),
    GoRoute(
      path: '/screen2',
      builder: (context, state) => const Screen2(),
    ),
    GoRoute(
      path: '/add-expense',
      builder: (context, state) => AddExpenseScreen(),
    ),
    GoRoute(
      path: '/expense-list',
      builder: (context, state) => ExpenseListScreen(),
    ),
  ],
);
