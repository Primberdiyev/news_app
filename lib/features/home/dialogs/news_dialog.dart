import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/utils/app_colors.dart';
import 'package:news_app/features/utils/app_text_styles.dart';

class NewsDialog extends StatelessWidget {
  const NewsDialog(
      {super.key,
      required this.imageLink,
      required this.title,
      required this.description});

  final String imageLink;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CachedNetworkImage(
            imageUrl: imageLink,
            imageBuilder: (context, imageProvider) => Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            placeholder: (context, url) => CircularProgressIndicator(
              color: AppColors.blue,
            ),
            errorWidget: (context, url, error) => Icon(
              Icons.error,
              size: 100,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: AppTextStyles.head24W600.copyWith(fontSize: 14),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Text(
              description,
              style: AppTextStyles.body16W400,
            ),
          ),
        ],
      ),
    );
  }
}
