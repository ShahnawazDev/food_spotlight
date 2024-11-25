
import 'dart:io';

import 'package:food_spotlight/models/product_info.dart';

class Search{

  final String productName;  // Name of the product (e.g., "Crunchy Almond Butter")
  final File productImage; // Image of product
  final ProductInfo productInfo;
  final String responseText;

  Search({required this.productName, required this.productImage, required this.productInfo, required this.responseText});
}
