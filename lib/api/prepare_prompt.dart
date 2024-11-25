String preparePrompt(String foodName) {
  return """
    **Task:** Analyze the provided image of a food product's ingredient list and, if available, consider the product name to generate a comprehensive report that empowers health-conscious consumers.

    **Input:**
    
    *   **Image:** [Insert image of the ingredient list here]
    *   **Product Name (Optional):** ${foodName ?? 'N/A'}
    
    **Desired Output:**
    
    **1. Ingredient Deep Dive:**
    
    *   For each ingredient, provide:
        *   **Common Name & Scientific Name:** Ensure clarity and avoid ambiguity.
        *   **Function/Purpose:** Explain the ingredient's role in the product (e.g., thickener, preservative, flavor enhancer).
        *   **Source:** Identify the origin (natural, synthetic, animal-derived) and consider specifying the type of source (e.g., plant-based, mineral). 
        *   **Health Implications:**
            *   **Allergens & Sensitivities:** Highlight potential allergens (e.g., gluten, soy, dairy) and sensitivities (e.g., FODMAPs for digestive issues).
            *   **Nutritional Impact:** Discuss the ingredient's contribution to the overall nutritional profile, including its impact on blood sugar, cholesterol, gut health, etc.
            *   **Potential Risks:** Mention any potential adverse effects or health risks associated with the ingredient based on scientific research and reputable sources.
        *   **Sustainability Considerations:** 
            *   **Environmental Impact:** Discuss the ingredient's environmental footprint considering factors like sourcing, production methods, water usage, and carbon emissions.
            *   **Ethical Sourcing:**  If relevant, provide information about fair trade practices, labor conditions, and animal welfare related to the ingredient's production.
        *   **Regulatory Status:** Mention any relevant regulatory information or certifications (e.g., organic, non-GMO, kosher). 
    
    **2.  Product-Level Insights:**
    
    *   **Nutritional Breakdown:** Provide a detailed analysis of the product's nutritional content, including:
        *   Macronutrients (protein, carbohydrates, fats) with breakdown of subtypes (e.g., saturated vs. unsaturated fats, sugars vs. fiber).
        *   Micronutrients (vitamins and minerals) with information on their importance for health. 
        *   Calorie content per serving and per package.
    *   **Health Goal Alignment:** 
        *   Analyze how the product fits into common dietary goals such as weight management, heart health, blood sugar control, gut health, and athletic performance. 
        *   Consider specific dietary needs like vegan, vegetarian, gluten-free, etc. 
    *   **Product Comparisons & Alternatives:**
        *   Suggest similar products with potentially healthier or more sustainable profiles based on the analyzed ingredients and user preferences.
        *   Provide comparisons of key nutritional factors and ingredient differences.
    
    **Output Format:**
    
    * Provide your response as a JSON object with the following schema: 
     "{
    "servingSize": "2 oz (56g)", // Serving size as indicated on packaging 
    "date": "2023-11-21T19:36:47.267Z", // Date and time of the search (example format, will vary)
    "ingredients": [
      {
        "name": "Organic Whole Wheat Flour", // Common name of the ingredient
        "scientificName": "Triticum aestivum", // Scientific name for precise identification
        "function": "Main ingredient", // Role of the ingredient in the product
        "source": "USA", // Origin or source of the ingredient
        "healthImplications": "Good source of fiber", // Potential health effects
        "sustainability": "Sustainably farmed", // Information on sustainability of sourcing
        "isOrganic": true, // Whether the ingredient is organic
        "isGMO": false, // Whether the ingredient is genetically modified
        "isFairTrade": false // Whether the ingredient is fair trade certified
      }
    ],
    "nutritionalInfo": {
      "servingSize": "2 oz (56g)", // Serving size for the nutritional information
      "calories": "200", // Calories per serving
      "macronutrients": [ 
        {"name": "Total Fat", "amount": "1g"},
        {"name": "Protein", "amount": "7g"},
        {"name": "Total Carbohydrates", "amount": "42g"}
      ],
      "micronutrients": [
        {"name": "Iron", "amount": "8% DV"} 
      ],
      "dailyValuePercentage": {"Iron": "8%", "Calcium": "2%"}, // % Daily Value for each nutrient
      "addedSugar": "0", // Amount of added sugar per serving
      "naturalSugar": "2", // Amount of naturally occurring sugar per serving
      "sugarAlcohol": "0" // Amount of sugar alcohol per serving
    },
    "tags": ["organic", "whole wheat", "vegan"], // Tags associated with the product
    "categories": ["pasta", "grains"], // Categories the product belongs to
    "labels": ["USDA Organic"], // Certification labels 
    "allergens": ["Wheat"], // Potential allergens present
    "diets": ["Vegetarian", "Vegan"], // Suitable diets for the product
    "healthLabels": ["Good source of fiber"], // Health claims about the product 
    "cautions": [] // Cautions or warnings associated with the product
  }"
       
    """;
}

String productInfoModelClass = """
ProductInfo(
    servingSize: "2 oz (56g)",  // Serving size as indicated on packaging (e.g., "2 tablespoons")
    date: DateTime.now(), // Date and time of the search
    ingredients: [
      Ingredient(
        name: "Organic Whole Wheat Flour",
        scientificName: "Triticum aestivum",
        function: "Main ingredient",
        source: "USA",
        healthImplications: "Good source of fiber",
        sustainability: "Sustainably farmed",
        isOrganic: true,
        isGMO: false,
        isFairTrade: false,
      )
    ], // List of ingredients in the product
    nutritionalInfo: NutritionalInfo(
      servingSize: "2 oz (56g)",
      calories: 200,
      macronutrients: [
        MacroNutrient(name: "Total Fat", amount: "1g"),
        MacroNutrient(name: "Protein", amount: "7g"),
        MacroNutrient(name: "Total Carbohydrates", amount: "42g"),
      ], // Nutritional information of the product
      micronutrients: [
        MicroNutrient(name: "Iron", amount: "8% DV"),
      ],
      dailyValuePercentage: {"Iron": "8%", "Calcium": "2%"},
      addedSugar: 0,
      naturalSugar: 2,
      sugarAlcohol: 0,
    ),
    tags: ["organic", "whole wheat", "vegan"],// Tags like "vegan", "gluten-free", etc.
    categories: ["pasta", "grains"], // Categories like "nut butters", "snacks", etc.
    labels: ["USDA Organic"], // Certification labels like "Organic", "Non-GMO"
    allergens: ["Wheat"], // Potential allergens present
    diets: ["Vegetarian", "Vegan"], // Suitable diets like "Keto", "Paleo"
    healthLabels: ["Good source of fiber"], // Health claims like "Heart-Healthy"
    cautions: [], // Cautions or warnings
  );
""";

String productInfoJSON = """
  {
    "servingSize": "2 oz (56g)", // Serving size as indicated on packaging 
    "date": "2023-11-21T19:36:47.267Z", // Date and time of the search (example format, will vary)
    "ingredients": [
      {
        "name": "Organic Whole Wheat Flour", // Common name of the ingredient
        "scientificName": "Triticum aestivum", // Scientific name for precise identification
        "function": "Main ingredient", // Role of the ingredient in the product
        "source": "USA", // Origin or source of the ingredient
        "healthImplications": "Good source of fiber", // Potential health effects
        "sustainability": "Sustainably farmed", // Information on sustainability of sourcing
        "isOrganic": true, // Whether the ingredient is organic
        "isGMO": false, // Whether the ingredient is genetically modified
        "isFairTrade": false // Whether the ingredient is fair trade certified
      }
    ],
    "nutritionalInfo": {
      "servingSize": "2 oz (56g)", // Serving size for the nutritional information
      "calories": 200, // Calories per serving
      "macronutrients": [ 
        {"name": "Total Fat", "amount": "1g"},
        {"name": "Protein", "amount": "7g"},
        {"name": "Total Carbohydrates", "amount": "42g"}
      ],
      "micronutrients": [
        {"name": "Iron", "amount": "8% DV"} 
      ],
      "dailyValuePercentage": {"Iron": "8%", "Calcium": "2%"}, // % Daily Value for each nutrient
      "addedSugar": 0, // Amount of added sugar per serving
      "naturalSugar": 2, // Amount of naturally occurring sugar per serving
      "sugarAlcohol": 0 // Amount of sugar alcohol per serving
    },
    "tags": ["organic", "whole wheat", "vegan"], // Tags associated with the product
    "categories": ["pasta", "grains"], // Categories the product belongs to
    "labels": ["USDA Organic"], // Certification labels 
    "allergens": ["Wheat"], // Potential allergens present
    "diets": ["Vegetarian", "Vegan"], // Suitable diets for the product
    "healthLabels": ["Good source of fiber"], // Health claims about the product 
    "cautions": [] // Cautions or warnings associated with the product
  }
""";
