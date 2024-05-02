import 'package:flutter/material.dart';

class CustomeAppBar extends StatelessWidget {
  final String userName;
  const CustomeAppBar({

    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Hello Ankit",style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold
              ),),
              Text("Start your day with a healthy meal !!",style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey
              ),),

            ],
          ),
          GestureDetector(
            onTap: (){

            },

            child: Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                child: Icon(Icons.person,size: 28,color: Colors.green,),
              ),
            ),
          ),


        ],
      ),
    );
  }
}