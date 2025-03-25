import 'package:get_it/get_it.dart';
import '../application/cubit/app_cubit.dart';

final getIt = GetIt.instance;

void setupDI() {
  // Регистрация Cubit
  getIt.registerLazySingleton<AppCubit>(() => AppCubit());
}
