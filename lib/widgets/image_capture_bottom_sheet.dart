import 'dart:io';

import 'package:flutter/material.dart';

class ImageCaptureBottomSheet extends StatefulWidget {
  final File? image;
  final void Function(String) onSubmit;

  const ImageCaptureBottomSheet({super.key, this.image, required this.onSubmit});

  @override
  State<ImageCaptureBottomSheet> createState() => _ImageCaptureBottomSheetState();
}

class _ImageCaptureBottomSheetState extends State<ImageCaptureBottomSheet> {
  final TextEditingController foodNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.8,
        expand: false,
        snap: true,
        snapSizes: const [0.52,0.7, 0.8],
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                  child: TextField(
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
                if (widget.image != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        widget.image!,
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
                        WidgetStateProperty.all(Colors.green[200]),
                    fixedSize: WidgetStateProperty.all(const Size(200, 50)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onSubmit(foodNameController.text);
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