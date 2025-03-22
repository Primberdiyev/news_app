import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import 'package:news_app/features/home/dialogs/news_dialog.dart';
import 'package:news_app/features/home/models/article_model.dart';
import 'package:news_app/features/home/widgets/cached_image_widget.dart';
import 'package:news_app/features/utils/app_colors.dart';
import 'package:news_app/features/utils/app_text_styles.dart';
import 'package:news_app/features/utils/constants.dart';

class SliderNewsWidget extends StatelessWidget {
  const SliderNewsWidget({super.key, required this.articles});
  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: CarouselSlider(
          items: articles
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return NewsDialog(
                            imageLink: e.urlToImage ?? "",
                            title: e.title ?? '',
                            description: e.description ?? '',
                          );
                        });
                  },
                  child: Stack(children: [
                    CachedImageWidget(
                      imageLink: e.urlToImage ?? Constants.errorImageUrl,
                      imageWidth: 250,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Text(
                        "${e.title ?? ''}'",
                        style: AppTextStyles.head20W600
                            .copyWith(color: AppColors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),
                ),
              )
              .toList(),
          options: CarouselOptions(
            viewportFraction: 0.7,
            height: 180,
            animateToClosest: true,
            autoPlay: true,
            onPageChanged: (index, reason) {
              context.read<HomeBloc>().add(ChangeSlideIndexEvent(index));
            },
          ),
        ));
  }
}
