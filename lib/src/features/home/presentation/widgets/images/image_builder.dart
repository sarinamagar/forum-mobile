import 'package:flutter/material.dart';

class ImageBuilder extends StatelessWidget {
  final String imageUrl;
  final double? imagePath;
  final double? width;
  final double? height;
  final BoxFit? fit;
  const ImageBuilder(
      {super.key,
      required this.imageUrl,
      this.imagePath,
      this.width,
      this.height,
      this.fit});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
