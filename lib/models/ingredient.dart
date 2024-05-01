class Ingredient {
  final String name;                 // Common name of the ingredient (e.g., "Almonds")
  final String scientificName;      // Scientific name for precise identification (e.g., "Prunus dulcis")
  final String function;            // Role of the ingredient (e.g., "Main ingredient", "Thickener")
  final String source;              // Origin or source of the ingredient (e.g., "California")
  final String healthImplications;  // Potential health effects (e.g., "Good source of protein")
  final String sustainability;      // Information on sustainability of sourcing
  final bool isOrganic;             // Whether the ingredient is organic
  final bool isGMO;                // Whether the ingredient is genetically modified
  final bool isFairTrade;

  Ingredient({required this.name, required this.scientificName, required this.function, required this.source, required this.healthImplications, required this.sustainability, required this.isOrganic, required this.isGMO, required this.isFairTrade});           // Whether the ingredient is fair trade certified
}
