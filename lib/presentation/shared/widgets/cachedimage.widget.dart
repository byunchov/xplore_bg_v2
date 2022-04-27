import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeleton_text/skeleton_text.dart';

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;

  const CustomCachedImage({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      height: height ?? Get.height,
      width: width ?? Get.width,
      placeholder: (context, url) => SkeletonAnimation(child: Container(color: Colors.grey[300])),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey[300],
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.error),
            // SizedBox(height: 5),
            // Text("Error loding media!"),
          ],
        ),
      ),
    );
  }
}
