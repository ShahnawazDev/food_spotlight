class NutritionalInfo {
  final String servingSize; // Serving size for the nutritional information
  final String calories; // Calories per serving
  final List<MacroNutrient>
      macronutrients; // List of macronutrients (e.g., fat, protein)
  final List<MicroNutrient>
      micronutrients; // List of micronutrients (e.g., vitamins, minerals)
  final Map<String, String>
      dailyValuePercentage; // % Daily Value for each nutrient
  final String addedSugar; // Amount of added sugar per serving
  final String naturalSugar; // Amount of naturally occurring sugar per serving
  final String sugarAlcohol; // Amount of sugar alcohol per serving

  NutritionalInfo(
      {required this.servingSize,
      required this.calories,
      required this.macronutrients,
      required this.micronutrients,
      required this.dailyValuePercentage,
      required this.addedSugar,
      required this.naturalSugar,
      required this.sugarAlcohol});

  Map<String, dynamic> toJson() {
    return {
      'servingSize': servingSize,
      'calories': calories,
      'macronutrients': macronutrients.map((e) => e.toJson()).toList(),
      'micronutrients': micronutrients.map((e) => e.toJson()).toList(),
      'dailyValuePercentage': dailyValuePercentage,
      'addedSugar': addedSugar,
      'naturalSugar': naturalSugar,
      'sugarAlcohol': sugarAlcohol,
    };
  }

  factory NutritionalInfo.fromJson(Map<String, dynamic> json) {

    List<MacroNutrient> macroNutrients = (json['macroNutrients'] != null
        ? (json['macroNutrients'] as List<dynamic>).map((item) => MacroNutrient.fromJson(item)).toList()
        : <MacroNutrient>[]
    );

    List<MicroNutrient> microNutrients = (json['microNutrients'] != null
        ? (json['microNutrients'] as List<dynamic>).map((item) => MicroNutrient.fromJson(item)).toList()
        : <MicroNutrient>[]
    );

    Map<String, String> dailyValuePercentage = Map<String, String>.from(json['dailyValuePercentage']);

    return NutritionalInfo(
      servingSize: json['servingSize'],
      calories: json['calories'],
      macronutrients: macroNutrients,
      micronutrients: microNutrients,
      dailyValuePercentage: dailyValuePercentage,
      addedSugar: json['addedSugar'],
      naturalSugar: json['naturalSugar'],
      sugarAlcohol: json['sugarAlcohol'],
    );
  }
}

class MacroNutrient {
  final String name; // Name of the macronutrient (e.g., "Total Fat")
  final String amount; // Amount per serving (e.g., "16g")

  MacroNutrient({required this.name, required this.amount});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
    };
  }

  factory MacroNutrient.fromJson(Map<String, dynamic> json) {
    return MacroNutrient(
      name: json['name'],
      amount: json['amount'],
    );
  }
}

class MicroNutrient {
  final String name; // Name of the micronutrient (e.g., "Vitamin C")
  final String amount; // Amount per serving (e.g., "20mg")

  MicroNutrient({required this.name, required this.amount});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
    };
  }

  factory MicroNutrient.fromJson(Map<String, dynamic> json) {
    return MicroNutrient(
      name: json['name'],
      amount: json['amount'],
    );
  }
}
