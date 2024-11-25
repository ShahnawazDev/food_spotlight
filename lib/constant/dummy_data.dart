const demoProductInfoJsonString = '''{
  "servingSize": "2 oz (56g)",
  "date": "2023-11-21T19:36:47.267Z",
  "ingredients": [
    {
      "name": "Tomatoes",
      "scientificName": "Solanum lycopersicum",
      "function": "Main ingredient",
      "source": "India",
      "healthImplications": "Good source of vitamins and minerals",
      "sustainability": "Sustainably grown",
      "isOrganic": true,
      "isGMO": false,
      "isFairTrade": false
    },
    {
      "name": "Sugar",
      "scientificName": "Saccharum officinarum",
      "function": "Sweetener",
      "source": "India",
      "healthImplications": "High in calories, may contribute to weight gain and other health issues",
      "sustainability": "Sustainably grown",
      "isOrganic": true,
      "isGMO": false,
      "isFairTrade": false
    },
    {
      "name": "Vinegar",
      "scientificName": "Acetic acid",
      "function": "Preservative, adds tangy flavor",
      "source": "India",
      "healthImplications": "May help lower blood sugar levels and improve heart health",
      "sustainability": "Sustainably produced",
      "isOrganic": true,
      "isGMO": false,
      "isFairTrade": false
    },
    {
      "name": "Salt",
      "scientificName": "Sodium chloride",
      "function": "Preservative, enhances flavor",
      "source": "India",
      "healthImplications": "High intake may contribute to high blood pressure and other health issues",
      "sustainability": "Sustainably sourced",
      "isOrganic": false,
      "isGMO": false,
      "isFairTrade": false
    },
    {
      "name": "Spices",
      "scientificName": "Various",
      "function": "Adds flavor and aroma",
      "source": "India",
      "healthImplications": "May have antioxidant and anti-inflammatory properties",
      "sustainability": "Sustainably sourced",
      "isOrganic": true,
      "isGMO": false,
      "isFairTrade": false
    }
  ],
  "nutritionalInfo": {
    "servingSize": "2 oz (56g)",
    "calories": "110",
    "macronutrients": [
      {"name": "Total Fat", "amount": "0g"},
      {"name": "Protein", "amount": "1g"},
      {"name": "Total Carbohydrates", "amount": "24g"}
    ],
    "micronutrients": [
      {"name": "Vitamin C", "amount": "10% DV"},
      {"name": "Potassium", "amount": "2% DV"}
    ],
    "dailyValuePercentage": {"Vitamin C": "10%", "Potassium": "2%"},
    "addedSugar": "10g",
    "naturalSugar": "2g",
    "sugarAlcohol": "0g"
  },
  "tags": ["organic", "vegan", "gluten-free"],
  "categories": ["condiments", "sauces"],
  "labels": ["USDA Organic"],
  "allergens": [],
  "diets": ["Vegan", "Vegetarian", "Gluten-Free"],
  "healthLabels": ["Good source of vitamins and minerals"],
  "cautions": []
}
''';

const demoAPIResultString = '''
      ```json
{
  "servingSize": "2 oz (56g)",
  "date": "2023-11-21T19:36:47.267Z",
  "ingredients": [
    {
      "name": "Tomatoes",
      "scientificName": "Solanum lycopersicum",
      "function": "Main ingredient",
      "source": "India",
      "healthImplications": "Good source of vitamins and minerals",
      "sustainability": "Sustainably grown",
      "isOrganic": true,
      "isGMO": false,
      "isFairTrade": false
    },
    {
      "name": "Sugar",
      "scientificName": "Saccharum officinarum",
      "function": "Sweetener",
      "source": "India",
      "healthImplications": "High in calories, may contribute to weight gain and other health issues",
      "sustainability": "Sustainably grown",
      "isOrganic": true,
      "isGMO": false,
      "isFairTrade": false
    },
    {
      "name": "Vinegar",
      "scientificName": "Acetic acid",
      "function": "Preservative, adds tangy flavor",
      "source": "India",
      "healthImplications": "May help lower blood sugar levels and improve heart health",
      "sustainability": "Sustainably produced",
      "isOrganic": true,
      "isGMO": false,
      "isFairTrade": false
    },
    {
      "name": "Salt",
      "scientificName": "Sodium chloride",
      "function": "Preservative, enhances flavor",
      "source": "India",
      "healthImplications": "High intake may contribute to high blood pressure and other health issues",
      "sustainability": "Sustainably sourced",
      "isOrganic": false,
      "isGMO": false,
      "isFairTrade": false
    },
    {
      "name": "Spices",
      "scientificName": "Various",
      "function": "Adds flavor and aroma",
      "source": "India",
      "healthImplications": "May have antioxidant and anti-inflammatory properties",
      "sustainability": "Sustainably sourced",
      "isOrganic": true,
      "isGMO": false,
      "isFairTrade": false
    }
  ],
  "nutritionalInfo": {
    "servingSize": "2 oz (56g)",
    "calories": "110",
    "macronutrients": [
      {"name": "Total Fat", "amount": "0g"},
      {"name": "Protein", "amount": "1g"},
      {"name": "Total Carbohydrates", "amount": "24g"}
    ],
    "micronutrients": [
      {"name": "Vitamin C", "amount": "10% DV"},
      {"name": "Potassium", "amount": "2% DV"}
    ],
    "dailyValuePercentage": {"Vitamin C": "10%", "Potassium": "2%"},
    "addedSugar": "10g",
    "naturalSugar": "2g",
    "sugarAlcohol": "0g"
  },
  "tags": ["organic", "vegan", "gluten-free"],
  "categories": ["condiments", "sauces"],
  "labels": ["USDA Organic"],
  "allergens": [],
  "diets": ["Vegan", "Vegetarian", "Gluten-Free"],
  "healthLabels": ["Good source of vitamins and minerals"],
  "cautions": []
}
```
      ''';


// Search sampleSearch = Search(
//     productName: foodName,
//     productImage: image,  // Replace with actual image URL
//     productInfo: ProductInfo(
//       servingSize: "2 oz (56g)",
//       date: DateTime.now(),
//       ingredients: [
//         Ingredient(
//           name: "Organic Whole Wheat Flour",
//           scientificName: "Triticum aestivum",
//           function: "Main ingredient",
//           source: "USA",
//           healthImplications: "Good source of fiber",
//           sustainability: "Sustainably farmed",
//           isOrganic: true,
//           isGMO: false,
//           isFairTrade: false,
//         ),Ingredient(
//           name: "Organic Whole Wheat Flour",
//           scientificName: "Triticum aestivum",
//           function: "Main ingredient",
//           source: "USA",
//           healthImplications: "Good source of fiber",
//           sustainability: "Sustainably farmed",
//           isOrganic: true,
//           isGMO: false,
//           isFairTrade: false,
//         )
//       ],
//       nutritionalInfo: NutritionalInfo(
//         servingSize: "2 oz (56g)",
//         calories: 200,
//         macronutrients: [
//           MacroNutrient(name: "Total Fat", amount: "1g"),
//           MacroNutrient(name: "Protein", amount: "7g"),
//           MacroNutrient(name: "Total Carbohydrates", amount: "42g"),
//         ],
//         micronutrients: [
//           MicroNutrient(name: "Iron", amount: "8% DV"),
//         ],
//         dailyValuePercentage: {"Iron": "8%", "Calcium": "2%"},
//         addedSugar: 0,
//         naturalSugar: 2,
//         sugarAlcohol: 0,
//       ),
//       tags: ["organic", "whole wheat", "vegan"],
//       categories: ["pasta", "grains"],
//       labels: ["USDA Organic"],
//       allergens: ["Wheat"],
//       diets: ["Vegetarian", "Vegan"],
//       healthLabels: ["Good source of fiber"],
//       cautions: [],
//     )
// );
