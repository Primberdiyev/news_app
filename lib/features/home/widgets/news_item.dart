import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/extensions/date_time_ext.dart';
import 'package:news_app/features/home/dialogs/news_dialog.dart';
import 'package:news_app/features/utils/app_colors.dart';
import 'package:news_app/features/utils/app_text_styles.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.time,
    required this.description,
    required this.url,
    required this.author,
  });
  final String imageUrl;
  final String title;
  final String time;
  final String description;
  final String url;
  final String author;

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
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              placeholder: (context, url) => SizedBox(
                height: 100,
                width: 100,
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
                    'By $author',
                    style: AppTextStyles.body14W400,
                  ),
                  Row(
                    children: [
                      Text("Published ${time.getTimeAgo()}"),
                      Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.edit),
                      ),
                      Icon(
                        Icons.delete,
                        color: AppColors.red,
                      ),
                    ],
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
