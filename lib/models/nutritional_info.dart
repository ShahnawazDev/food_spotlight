

class NutritionalInfo {
  final String servingSize;        // Serving size for the nutritional information
  final num calories;              // Calories per serving
  final List<MacroNutrient> macronutrients; // List of macronutrients (e.g., fat, protein)
  final List<MicroNutrient> micronutrients; // List of micronutrients (e.g., vitamins, minerals)
  final Map<String, String> dailyValuePercentage; // % Daily Value for each nutrient
  final num addedSugar;            // Amount of added sugar per serving
  final num naturalSugar;          // Amount of naturally occurring sugar per serving
  final num sugarAlcohol;

  NutritionalInfo({required this.servingSize, required this.calories, required this.macronutrients, required this.micronutrients, required this.dailyValuePercentage, required this.addedSugar, required this.naturalSugar, required this.sugarAlcohol});          // Amount of sugar alcohol per serving
}

class MacroNutrient {
  final String name;   // Name of the macronutrient (e.g., "Total Fat")
  final String amount;

  MacroNutrient({required this.name, required this.amount}); // Amount per serving (e.g., "16g")
}

class MicroNutrient {
  final String name;   // Name of the micronutrient (e.g., "Vitamin C")
  final String amount;

  MicroNutrient({required this.name, required this.amount}); // Amount per serving (e.g., "20mg")
}