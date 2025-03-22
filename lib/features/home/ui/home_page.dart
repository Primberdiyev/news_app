import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import 'package:news_app/features/home/ui/category/category_news.dart';
import 'package:news_app/features/home/ui/country/country_news.dart';
import 'package:news_app/features/home/ui/tesla_news/tesla_news.dart';
import 'package:news_app/features/home/ui/profile/profile.dart';
import 'package:news_app/features/home/widgets/filtered_by_widget.dart';
import 'package:news_app/features/utils/app_colors.dart';
import 'package:news_app/features/utils/app_images.dart';
import 'package:news_app/features/utils/app_texts.dart';
import 'package:news_app/features/utils/sort_components.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pageController = PageController();
  final currentPagenIndex = ValueNotifier(0);
  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
            child: FilteredByWidget(),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (value) {
                currentPagenIndex.value = value;
              },
              children: [
                TeslaNews(),
                CategoryNews(),
                CountryNews(),
                Profile(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: currentPagenIndex,
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    pageController.jumpToPage(0);
                    context.read<HomeBloc>().add(GetNewsEvent(isTesla: true));
                  },
                  icon: Icon(
                    Icons.search,
                    color: value == 0 ? AppColors.blue : Colors.black,
                    size: 40,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    pageController.jumpToPage(1);
                    context.read<HomeBloc>().add(
                          GetNewsEvent(
                            categoryName: AppTexts.technology,
                            country: null,
                            filterType: AppTexts.category,
                          ),
                        );
                  },
                  icon: Image.asset(
                    AppImages.category.image,
                    height: 40,
                    width: 40,
                    color: value == 1 ? AppColors.blue : Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    pageController.jumpToPage(2);
                    context.read<HomeBloc>().add(
                          GetNewsEvent(
                            categoryName: null,
                            country: SortComponents.countryComponents.first,
                            filterType: AppTexts.country,
                          ),
                        );
                  },
                  icon: Image.asset(
                    AppImages.country.image,
                    width: 40,
                    height: 40,
                    color: value == 2 ? AppColors.blue : Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    pageController.jumpToPage(3);
                  },
                  icon: Image.asset(
                    AppImages.profile.image,
                    height: 40,
                    width: 40,
                    color: value == 3 ? AppColors.blue : Colors.black,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
