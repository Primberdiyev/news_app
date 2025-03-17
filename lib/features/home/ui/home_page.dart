import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import 'package:news_app/features/home/widgets/action_button.dart';
import 'package:news_app/features/home/widgets/failure_widget.dart';
import 'package:news_app/features/home/widgets/loading_widget.dart';
import 'package:news_app/features/home/widgets/news_item.dart';
import 'package:news_app/features/utils/app_colors.dart';
import 'package:news_app/features/utils/app_images.dart';
import 'package:news_app/features/utils/app_text_styles.dart';
import 'package:news_app/features/utils/app_texts.dart';
import 'package:news_app/features/utils/constants.dart';
import 'package:news_app/features/utils/country_filter_components.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<HomeBloc>().add(GetNewsEvent(countryName: 'us'));
    super.initState();
  }

  final countryComponents = CountryFilterComponents().countryComponents;
  List<String> filters = [AppTexts.country, AppTexts.category];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeSuccessState) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 80,
                left: 20,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // FilterCountry(),

                  Row(
                    children: [
                      Image.asset(
                        AppImages.splash.image,
                        height: 30,
                        width: 30,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        AppTexts.bbcApp,
                        style: AppTextStyles.head24W600.copyWith(fontSize: 20),
                      ),
                      Spacer(),
                      Text(AppTexts.filteredBy,
                          style: AppTextStyles.body16W400),
                      SizedBox(
                        width: 10,
                      ),
                      DropdownButton<String>(
                        alignment: Alignment.centerLeft,
                        value: state.filterType ?? AppTexts.country,
                        focusColor: AppColors.textFieldColor,
                        dropdownColor: AppColors.textFieldColor,
                        items: filters.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            alignment: Alignment.centerLeft,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          context.read<HomeBloc>().add(ChangeFilterTypeEvent(
                              newValue ?? AppTexts.category));
                        },
                      )
                    ],
                  ),
                  // SearchNews(
                  //   news: state.articles,
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 70,
                    child: ListView.builder(
                      itemCount: countryComponents.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final item = countryComponents[index];
                        final selectedCountry = state.selectedCountry ??
                            context.read<HomeBloc>().defaultCountry;
                        return GestureDetector(
                          onTap: () => context
                              .read<HomeBloc>()
                              .add(FilterCountryEvent(item)),
                          child: Container(
                            height: 50,
                            margin:
                                EdgeInsets.only(top: 10, bottom: 10, right: 10),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedCountry.name == item.name
                                  ? AppColors.primary
                                  : AppColors.textFieldColor,
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  item.imageAsset,
                                  height: 24,
                                  width: 24,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  item.name,
                                  style: AppTextStyles.body16W400.copyWith(
                                    color: selectedCountry.name == item.name
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Text(
                    AppTexts.filterByCategory,
                    style: AppTextStyles.head24W600.copyWith(fontSize: 20),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.articles?.length ?? 0,
                      itemBuilder: (context, index) {
                        final newData = state.articles?[index];
                        return NewsItem(
                            imageUrl:
                                newData?.urlToImage ?? Constants.errorImageUrl,
                            title: newData?.title ?? '',
                            time: newData?.publishedAt ?? '',
                            description: newData?.description ?? "",
                            url: newData?.url ?? '');
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
      floatingActionButton: ActionButton(),
    );
  }
}
