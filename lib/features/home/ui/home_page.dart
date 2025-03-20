import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import 'package:news_app/features/home/widgets/action_button.dart';
import 'package:news_app/features/home/widgets/cached_image_widget.dart';
import 'package:news_app/features/home/widgets/failure_widget.dart';
import 'package:news_app/features/home/widgets/filtered_by_widget.dart';
import 'package:news_app/features/home/widgets/loading_widget.dart';
import 'package:news_app/features/home/widgets/news_item.dart';
import 'package:news_app/features/home/widgets/sort_widget.dart';
import 'package:news_app/features/routes/name_routes.dart';
import 'package:news_app/features/utils/app_text_styles.dart';
import 'package:news_app/features/utils/constants.dart';
import 'package:news_app/features/utils/sort_components.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeSuccessState) {
            final bool isCountry = state.selectedCountry != null;
            final items = isCountry
                ? SortComponents.countryComponents
                : SortComponents.categories;
            final selectedItem =
                isCountry ? state.selectedCountry : state.selectedCategory;
            return Padding(
              padding: const EdgeInsets.only(
                top: 80,
                left: 20,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FilteredByWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  SortWidget(
                    items: items,
                    isCountry: isCountry,
                    selectedItem: selectedItem,
                    function: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: CarouselSlider(
                      items: state.articles
                          .map(
                            (e) => Stack(children: [
                              CachedImageWidget(
                                imageLink:
                                    e.urlToImage ?? Constants.errorImageUrl,
                                imageWidth: 220,
                                imageHeight: 150,
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Text(
                                  "${e.title ?? ''}'",
                                  style: AppTextStyles.head20W600,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ]),
                          )
                          .toList(),
                      options: CarouselOptions(
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          context
                              .read<HomeBloc>()
                              .add(ChangeSlideIndexEvent(index));
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.articles.length,
                      itemBuilder: (context, index) {
                        final newData = state.articles[index];
                        return NewsItem(
                          article: newData,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is HomeLoadingState) {
            return LoadingWidget();
          }
          return FailureWidget();
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 10, left: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ActionButton(
              icon: Icons.refresh,
              function: () {
                final homeBloc = context.read<HomeBloc>();
                homeBloc.add(RefleshNewsEvent());
                //  context.read<AuthBloc>().add(DeleteUserEvent());
              },
            ),
            ActionButton(
              icon: Icons.add,
              function: () {
                Navigator.pushNamed(context, NameRoutes.addtArticle);
              },
            ),
          ],
        ),
      ),
    );
  }
}
