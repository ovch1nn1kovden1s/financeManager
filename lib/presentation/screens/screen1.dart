import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen 1')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('This is Screen 1'),
            ElevatedButton(
              onPressed: () => context.go('/screen2'),
              child: const Text('Go to Screen 2'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.go('/add-expense'),
              child: const Text('Go to Add Expense'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.go('/expense-list'),
              child: const Text('Go to Expense List'),
            ),
          ],
        ),
      ),
    );
  }
}
