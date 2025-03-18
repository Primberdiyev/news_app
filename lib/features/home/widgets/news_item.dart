import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/extensions/date_time_ext.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import 'package:news_app/features/home/dialogs/news_dialog.dart';
import 'package:news_app/features/home/models/article_model.dart';
import 'package:news_app/features/utils/app_colors.dart';
import 'package:news_app/features/utils/app_text_styles.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return NewsDialog(
                imageLink: article.urlToImage ?? "",
                title: article.title ?? '',
                description: article.description ?? '',
              );
            });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: article.urlToImage ?? '',
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
                    article.title ?? "",
                    style: AppTextStyles.body16W400,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'By ${article.author}',
                    style: AppTextStyles.body14W400,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Published ${article.publishedAt?.getTimeAgo()}",
                        style: AppTextStyles.body14W400
                            .copyWith(fontSize: 12, color: AppColors.black),
                      ),
                      Spacer(),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          context.read<HomeBloc>().add(
                                DeleteNewsByIdEvent(article: article),
                              );
                        },
                        icon: Icon(
                          Icons.delete,
                          color: AppColors.red,
                        ),
                      )
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
