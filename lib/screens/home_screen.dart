import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_spotlight/api/network_service.dart';
import 'package:food_spotlight/constant/text_constant.dart';
import 'package:food_spotlight/models/search.dart';
import 'package:food_spotlight/screens/details_screen.dart';
import 'package:food_spotlight/screens/waiting_screen.dart';
import 'package:food_spotlight/widgets/food_item_list.dart';
import 'package:food_spotlight/widgets/image_capture_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_spotlight/providers/recent_searches_provider.dart';

import '../widgets/custom_app_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  File? image;
  final networkService = NetworkService();

  Future<void> _analyzeImage(File? image, String foodName) async {
    if (image == null) return;

    Search search = await networkService.analyzeImageAndText(image, foodName);

    ref.read(recentSearchesProvider.notifier).addSearch(search);

    // Navigate to DetailsScreen
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsScreen(search: search),
        ),
      );
    }
  }

  void showBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return ImageCaptureBottomSheet(
          image: image,
          onSubmit: (String foodName) {
            if (foodName.isEmpty && image == null) {
              return;
            }
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const WaitingScreen(),
              ),
            );
            _analyzeImage(image, foodName);
          },
        );
      },
    );
  }

  Future<void> getImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
      showBottomSheet();
    }
  }

  Future<void> getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
      showBottomSheet();
    }
  }

  @override
  Widget build(BuildContext context) {
    final recentSearches = ref.watch(recentSearchesProvider);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * .08,
          ),
          const CustomAppBar(),
          Expanded(
            child: recentSearches.isEmpty
                ? Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      TextConstants.homeScreenCenterText,
                      style: const TextStyle(
                        fontSize: 30,
                        // fontWeight: FontWeight.w700,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: recentSearches.length,
                    itemBuilder: (context, index) {
                      final search = recentSearches[index];
                      return FoodListItems(
                        search: search,
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.all(10),

          decoration: BoxDecoration(
            color: Colors.green[200],
            borderRadius: BorderRadius.circular(16),
          ),
          width: 150,
          // height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                heroTag: 'camera',
                isExtended: true,
                onPressed: getImageFromCamera,
                child: const Icon(
                  Icons.camera_alt,
                  size: 30,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                heroTag: 'gallery',
                isExtended: true,
                onPressed: getImageFromGallery,
                child: const Icon(
                  Icons.file_present_rounded,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
