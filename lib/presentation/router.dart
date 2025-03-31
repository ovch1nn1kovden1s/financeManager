import 'package:go_router/go_router.dart';
import 'screens/add_expense_screen.dart';
import 'screens/expense_list_screen.dart';
import 'screens/category_expenses_screen.dart';
import '../../core/expense_model.dart';

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
    GoRoute(
      path: '/category-expenses/:categoryName',
      builder: (context, state) {
        final categoryName = state.pathParameters['categoryName']!;
        final expenses = state.extra as List<Expense>;
        return CategoryExpensesScreen(
          categoryName: categoryName,
          expenses: expenses,
        );
      },
    ),
  ],
);
