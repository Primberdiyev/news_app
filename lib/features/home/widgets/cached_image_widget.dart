import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/utils/app_colors.dart';

class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({
    super.key,
    required this.imageLink,
    this.imageHeight = 180,
    this.imageWidth = 150,
  });
  final String imageLink;
  final double imageHeight;
  final double imageWidth;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageLink,
      imageBuilder: (context, imageProvider) => Container(
        height: imageHeight,
        width: imageWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      placeholder: (context, url) => SizedBox(
        height: imageHeight,
        width: imageWidth,
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.blue,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Icon(
        Icons.error,
        size: 100,
      ),
    );
  }
}
