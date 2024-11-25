import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({super.key});

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> with TickerProviderStateMixin {
  late AnimationController waitingAnimationController;
  late AnimationController hourglassAnimationController;

  @override
  initState() {
    super.initState();
    waitingAnimationController = AnimationController(vsync: this);
    hourglassAnimationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    waitingAnimationController.dispose();
    hourglassAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Don't think about food!",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const Text(
              "We are analyzing it for you!",
              style: TextStyle(fontSize: 30),
            ),
            Center(
              child: Lottie.asset('assets/lottie/waiting_animation.json',
                  controller: waitingAnimationController,
                  onLoaded: (composition) {
                waitingAnimationController
                  ..duration = composition.duration
                  ..repeat();
              }),
            ),
            const Center(
              child: Text(
                'Preparing your food analysis report...',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Center(
              child: Lottie.asset('assets/lottie/hourglass_loading.json',
                  height: 100, controller: hourglassAnimationController,
                  onLoaded: (composition) {
                hourglassAnimationController
                  ..duration = composition.duration
                  ..repeat();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
