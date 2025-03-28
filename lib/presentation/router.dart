import 'package:go_router/go_router.dart';
import 'screens/add_expense_screen.dart';
import 'screens/expense_list_screen.dart';

final router = GoRouter(
  initialLocation: '/expense-list',
  routes: [
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
