// lib/ui/camera/widgets/display_picture_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('촬영한 사진')),
      body: Image.file(File(imagePath)),
    );
  }
}