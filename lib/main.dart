import 'package:flutter/material.dart';
import 'core/di_container.dart';
import 'presentation/app_widget.dart';

void main() {
  setupDI();
  runApp(const AppWidget());
}
