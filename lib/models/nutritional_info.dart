class NutritionalInfo {
  final num calories;
  final List<MacroNutrient> macronutrients;
  final List<MicroNutrient> micronutrients;

  NutritionalInfo({
    required this.calories,
    required this.macronutrients,
    required this.micronutrients,
  });
}

class MacroNutrient {
  final String name;
  final String amount;

  MacroNutrient({
    required this.name,
    required this.amount,
  });
}

class MicroNutrient {
  final String name;
  final String amount;

  MicroNutrient({
    required this.name,
    required this.amount,
  });
}