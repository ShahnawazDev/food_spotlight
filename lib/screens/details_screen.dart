import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:food_spotlight/models/search.dart';
import 'package:food_spotlight/screens/chat_screen.dart';

class DetailsScreen extends StatelessWidget {
  final Search search;

  const DetailsScreen({super.key, required this.search});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        onPressed: () {
          String responseText = search.responseText;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                contextText: responseText,
                productName: search.productName,
              ),
            ),
          );
        },
        label: const Text('Ask Questions'),
        icon: const Icon(Icons.question_answer_outlined),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.green,
            iconTheme: const IconThemeData(color: Colors.white),
            expandedHeight: size.height * .25,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                search.productName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Stack(
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
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            floating: true,
            pinned: true,
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Markdown(data: search.responseText),
            ),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:food_spotlight/models/nutritional_info.dart';

// import 'package:food_spotlight/models/search.dart';
// import 'package:food_spotlight/screens/chat_screen.dart';
// import 'package:food_spotlight/widgets/category_widget.dart';
// import 'package:food_spotlight/widgets/ingredients_list_widget.dart';
// import 'package:food_spotlight/widgets/macro_nutrients_widget.dart';
// import 'package:food_spotlight/widgets/micro_nutrients_widget.dart';

// class DetailsScreen extends StatelessWidget {
//   final Search search;

//   const DetailsScreen({super.key, required this.search});

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       floatingActionButton: FloatingActionButton.extended(
//         isExtended: true,
//         onPressed: () {
//           String responseText = search.responseText;
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => ChatScreen(
//                 contextText: responseText,
//                 productName: search.productName,
//               ),
//             ),
//           );
//         },
//         label: const Text('Ask Questions'),
//         icon: const Icon(Icons.question_answer_outlined),
//       ),
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             backgroundColor: Colors.green,
//             iconTheme: const IconThemeData(color: Colors.white),
//             expandedHeight: size.height * .25,
//             flexibleSpace: FlexibleSpaceBar(
//               title: Text(
//                 search.productName,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               background: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   Image.file(
//                     search.productImage,
//                     fit: BoxFit.cover,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.bottomLeft,
//                         end: Alignment.topRight,
//                         colors: [
//                           Colors.black.withOpacity(0.7),
//                           Colors.transparent
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             floating: true,
//             pinned: true,
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: size.height * .03,
//                   ),
//                   IngredientsListWidget(
//                     ingredients: search.productInfo.ingredients,
//                   ),
//                   SizedBox(
//                     height: size.height * .03,
//                   ),
//                   MacroNutrientsWidget(
//                     size: size,
//                     search: search,
//                     nutritionalInfo: search.productInfo.nutritionalInfo,
//                   ),
//                   SizedBox(
//                     height: size.height * .03,
//                   ),
//                   CategoryWidget(size: size, search: search),
//                   SizedBox(
//                     height: size.height * .03,
//                   ),
//                   MicroNutrientsWidget(
//                     size: size,
//                     search: search,
//                     nutritionalInfo: search.productInfo.nutritionalInfo,
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }






