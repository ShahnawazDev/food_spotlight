import 'package:flutter/material.dart';
import 'package:food_spotlight/models/search.dart';

class DetailsScreen extends StatelessWidget {
  final Search search;

  const DetailsScreen({super.key, required this.search});

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    final List<String> items = List.generate(20, (index) => 'Item $index');
    return Scaffold(

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.green,
            iconTheme: const IconThemeData(color: Colors.white),
            expandedHeight: size.height * .25,
            flexibleSpace: FlexibleSpaceBar(

              title: Text(search.productName,style: const TextStyle(
                fontWeight: FontWeight.bold,

              ),),
              background:   Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(
                     search.productImage,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            floating: true,
            pinned: true,
          ),


          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                children: [
                  SizedBox(height: size.height*.08,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.green,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text("INGREDIENTS",style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.green
                        ),),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.green,
                        ),
                      ),

                    ],
                  ),







                  // Expanded(
                  //
                  //   child: ListView.builder(
                  //     itemCount: search.productInfo.ingredients.length,
                  //     // itemCount: 2,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       var ingredientItem= search.productInfo.ingredients[index];
                  //
                  //       return const ListTile(
                  //
                  //
                  //       );
                  //
                  //
                  //   },
                  //
                  //
                  //
                  //   ),
                  // )


                ],
              ),
            ),
          )

        ],
      ),
      // appBar: AppBar(
      //   title: Text(search.productName),
      // ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Image.file(search.productImage),
      //       const Padding(
      //         padding: EdgeInsets.all(16.0),
      //         child: Text(
      //           'Ingredients:',
      //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      //         ),
      //       ),
      //       // Display ingredients using IngredientTile
      //       ...search.productInfo.ingredients.map(
      //         (ingredient) => IngredientTile(ingredient: ingredient),
      //       ),
      //       const Padding(
      //         padding: EdgeInsets.all(16.0),
      //         child: Text(
      //           'Nutritional Information:',
      //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      //         ),
      //       ),
      //       // Display nutritional information using NutritionalInfoCard
      //       NutritionalInfoCard(
      //         nutritionalInfo: search.productInfo.nutritionalInfo,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
