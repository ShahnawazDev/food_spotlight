import 'dart:io';

import 'package:flutter/material.dart';

class ImageCaptureBottomSheet extends StatelessWidget {
  final File? image;
  final foodNameController = TextEditingController();
  final void Function(String) onSubmit;

  ImageCaptureBottomSheet({super.key, this.image, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.8,
        expand: false,
        snap: true,
        snapSizes: const [0.6, 0.8],
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                  child: TextField(
                    onSubmitted: (value) {
                      foodNameController.text = value;
                      onSubmit(value);
                    },
                    controller: foodNameController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      hintText: 'Enter food name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                ),
                if (image != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        image!,
                        height: 400,
                        width: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.green[200]),
                    fixedSize: MaterialStateProperty.all(const Size(200, 50)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    onSubmit(foodNameController.text);
                  },
                  child: const Text(
                    "Analyse",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
