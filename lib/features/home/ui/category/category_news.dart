import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import 'package:news_app/features/home/widgets/failure_widget.dart';
import 'package:news_app/features/home/widgets/loading_widget.dart';
import 'package:news_app/features/home/widgets/news_item.dart';
import 'package:news_app/features/home/widgets/slider_news_widget.dart';
import 'package:news_app/features/home/widgets/sort_widget.dart';
import 'package:news_app/features/utils/sort_components.dart';

class CategoryNews extends StatefulWidget {
  const CategoryNews({super.key});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccessState) {
          final items = SortComponents.categories;
          final selectedItem = state.selectedCategory;
          return Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                SortWidget(
                  items: items,
                  isCountry: false,
                  selectedItem: selectedItem,
                  function: () {},
                ),
                SliderNewsWidget(
                  articles: state.articles,
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
    );
  }
}
