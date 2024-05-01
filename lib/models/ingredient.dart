class Ingredient {
  final String name;
  final String scientificName; // Optional
  final String function;
  final String source;
  final String healthImplications;
  final String sustainability;

  Ingredient({
    required this.name,
    this.scientificName = "",
    required this.function,
    required this.source,
    required this.healthImplications,
    required this.sustainability,
  });
}