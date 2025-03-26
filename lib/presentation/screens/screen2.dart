import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('This is Screen 2'),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go back to Screen 1'),
            ),
          ],
        ),
      ),
    );
  }
}
