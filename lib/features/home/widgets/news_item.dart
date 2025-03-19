import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/extensions/date_time_ext.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import 'package:news_app/features/home/dialogs/edit_dialog.dart';
import 'package:news_app/features/home/dialogs/news_dialog.dart';
import 'package:news_app/features/home/models/article_model.dart';
import 'package:news_app/features/home/widgets/cached_image_widget.dart';
import 'package:news_app/features/utils/app_colors.dart';
import 'package:news_app/features/utils/app_text_styles.dart';
import 'package:news_app/features/utils/constants.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
      child: Container(
        width: size.width - 40,
        margin: EdgeInsets.symmetric(vertical: 15),
        height: 180,
        child: Row(
          children: [
            CachedImageWidget(
                imageLink: article.urlToImage ?? Constants.errorImageUrl),
            SizedBox(
              width: 20,
            ),
            SizedBox(
              height: 180,
              width: size.width - 210,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title ?? "",
                    style: AppTextStyles.body14W400.copyWith(
                        fontWeight: FontWeight.bold, color: AppColors.black),
                  ),
                  Spacer(),
                  Text(
                    'By ${article.author ?? ''}',
                    style: AppTextStyles.body14W400,
                  ),
                  SizedBox(
                    height: 10,
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
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return EditDialog(
                                  article: article,
                                );
                              });
                        },
                        child: Icon(Icons.edit),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<HomeBloc>().add(
                                DeleteNewsByIdEvent(article: article),
                              );
                        },
                        child: Icon(
                          Icons.delete,
                          color: AppColors.red,
                        ),
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
