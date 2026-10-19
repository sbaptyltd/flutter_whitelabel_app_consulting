
import 'package:flutter/material.dart';
import 'features/home/home_screen.dart';

void main() {
  runApp(const ExpertConsultingApp());
}

class ExpertConsultingApp extends StatelessWidget {
  const ExpertConsultingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expert Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF146C70),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
      ),
      home: const HomeScreen(),
    );
  }
}
