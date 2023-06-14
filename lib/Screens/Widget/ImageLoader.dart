import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageLoader extends StatelessWidget {
  final String imageUrl;
  final BorderRadius? borderRadius;

  const ImageLoader({Key? key, required this.imageUrl, this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: imageUrl,
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
    return borderRadius != null
        ? ClipRRect(
            borderRadius: borderRadius,
            child: imageWidget,
          )
        : imageWidget;
  }
}
