import 'package:go_router/go_router.dart';
import 'screens/screen1.dart';
import 'screens/screen2.dart';
import 'screens/screen3.dart';

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
      path: '/screen3',
      builder: (context, state) => const Screen3(),
    ),
  ],
);
