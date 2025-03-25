import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/di_container.dart';
import '../application/cubit/app_cubit.dart';
import 'router.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      builder: (context, child) {
        return BlocProvider<AppCubit>(
          create: (_) => getIt<AppCubit>(),
          child: child!,
        );
      },
    );
  }
}
