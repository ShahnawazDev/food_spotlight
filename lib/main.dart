import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_spotlight/screens/home_screen.dart';
import 'package:food_spotlight/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('onboardingComplete') ?? false);

    return seen;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _checkFirstSeen(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  MaterialApp(
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.green,
                ),
                scaffoldBackgroundColor: Colors.green.shade100,
                useMaterial3: true,
              ),
              home: const SplashPage(),
            );
          } else {
            return MaterialApp(
              title: 'Food Spotlight',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.green,
                ),
                scaffoldBackgroundColor: Colors.green.shade100,
                useMaterial3: true,
              ),
              home:
                  snapshot.data ? const HomeScreen() : const OnboardingScreen(),
            );
          }
        });
  }
} // Replace with your actual path

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
