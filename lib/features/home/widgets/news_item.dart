import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/home/dialogs/news_dialog.dart';
import 'package:news_app/features/utils/app_colors.dart';
import 'package:news_app/features/utils/app_text_styles.dart';

class NewsItem extends StatelessWidget {
  const NewsItem(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.time,
      required this.description,
      required this.url});
  final String imageUrl;
  final String title;
  final String time;
  final String description;
  final String url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return NewsDialog(
                imageLink: imageUrl,
                title: title,
                description: description,
              );
            });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                width: 100,
                height: 100,
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
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.body16W400,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    time,
                    style: AppTextStyles.body16W400.copyWith(fontSize: 12),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
