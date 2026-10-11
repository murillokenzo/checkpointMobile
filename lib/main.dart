import 'package:flutter/material.dart';

import 'screens/home_page.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cinema - Controle de Lotação',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.vinho,
          brightness: Brightness.dark,
        ),
      ),
      home: const HomePage(),
    );
  }
}
