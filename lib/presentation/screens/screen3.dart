import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Screen3 extends StatelessWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen 3')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('This is Screen 3'),
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
