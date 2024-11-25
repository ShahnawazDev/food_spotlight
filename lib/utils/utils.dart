import 'package:shared_preferences/shared_preferences.dart';

void onboardingCompleted() async {
  // Save a flag indicating that onboarding has been completed
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('onboardingComplete', true);
}

void onboardingReset() async {
  // Reset the flag indicating that onboarding has been completed
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('onboardingComplete', false);
}
