

import 'package:flutter/material.dart';
import 'package:food_spotlight/models/ingredient.dart';

class IngredientTileWidget extends StatelessWidget {
  final Ingredient ingredient;

  const IngredientTileWidget({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
        child: InkWell(
          onTap: (){

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
                  color: Colors.green.shade100

              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround ,
                children: [
                  Expanded(
                    child: Text(ingredient.name,style: const TextStyle(

                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                  Container(
                      height: size.height *.05,
                      width: size.width*.09,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white
                      ),

                      child: const Icon(Icons.info,color: Colors.green,size: 22,))
                ],
              )),
        ));
  }
}