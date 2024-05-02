import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_spotlight/api/network_service.dart';
import 'package:food_spotlight/models/search.dart';
import 'package:food_spotlight/providers/recent_searches_provider.dart';
import 'package:food_spotlight/screens/details_screen.dart';
import 'package:image_picker/image_picker.dart';

class CaptureImageScreen extends ConsumerStatefulWidget {
  const CaptureImageScreen({super.key});

  @override
  ConsumerState<CaptureImageScreen> createState() => _CaptureImageScreenState();
}

class _CaptureImageScreenState extends ConsumerState<CaptureImageScreen> {
  File? _image;
  final _foodNameController = TextEditingController();
  final networkService = NetworkService();

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _analyzeImage() async {
    if (_image == null) return;

    Search search = await networkService.analyzeImageAndText(
      _image!,
      _foodNameController.text,
    );

    // Add the search result to the recent searches
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Image'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Display the selected image
              if (_image != null) Image.file(_image!),
              const SizedBox(height: 20),
              // Capture button
              ElevatedButton(
                onPressed: _getImage,
                child: const Text('Capture Image'),
              ),
              const SizedBox(height: 20),
              // Text field for food name
              TextField(
                controller: _foodNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter food name (optional)',
                ),
              ),
              const SizedBox(height: 20),
              // Analyze button
              ElevatedButton(
                onPressed: _analyzeImage,
                child: const Text('Analyze Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
