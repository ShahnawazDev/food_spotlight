import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_spotlight/screens/home_screen.dart';
import 'package:food_spotlight/screens/onboarding_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Spotlight',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green,),
        scaffoldBackgroundColor: Colors.green.shade100,
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
    );
  }

} // Replace with your actual path

