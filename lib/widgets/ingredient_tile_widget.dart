

import 'package:flutter/material.dart';
import 'package:food_spotlight/models/ingredient.dart';
import 'package:food_spotlight/widgets/ingredient_dialog.dart';

class IngredientTileWidget extends StatelessWidget {
  final Ingredient ingredient;

  const IngredientTileWidget({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
        child: InkWell(
          onTap: (){
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return IngredientDialog(ingredient: ingredient);
              },
            );
          },
          child: Container(
              height: size.height *.05,
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(6),

              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  color: Colors.green.shade300

              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround ,
                children: [
                  Expanded(
                    child: Text(ingredient.name,style: const TextStyle(

                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                  Container(
                      height: 34,
                      width: 34,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white
                      ),

                      child: const Icon(Icons.info,color: Colors.green,size: 22,))
                ],
              )),
        ));
  }
}