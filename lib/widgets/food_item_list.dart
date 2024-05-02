
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_spotlight/models/search.dart';
import 'package:food_spotlight/screens/details_screen.dart';

class FoodListItems extends StatelessWidget {
  const FoodListItems({
    super.key,
    required this.search,
    required this.size,
    required this.formattedDate,
    required this.index
  });

  final Search search;
  final Size size;
  final String formattedDate;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DetailsScreen(search: search),
              )
          );
        },
        child: Container(
          height: size.height *.15,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: Container(
                  width: size.width*.24,
                  height: size.height *.11,//
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      search.productImage,

                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(search.productName,style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700
                      ),),
                      Text(search.productInfo.ingredients[index].name,style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54
                      ),),
                      Text(search.productInfo.tags[index],style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54
                      ),),
                      Text(formattedDate,style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey
                      ),),



                    ],
                  ),
                ),

              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(13),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Adjust opacity as needed
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],

                      ),
                      child: const Center(
                        child:  Icon(Icons.radio_button_checked_rounded,size: 24,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),

                ],
              )



            ],
          ),
        ),
      ),
    );
  }
}