import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import 'package:news_app/features/utils/app_colors.dart';
import 'package:news_app/features/utils/app_text_styles.dart';
import 'package:news_app/features/utils/app_texts.dart';
import 'package:news_app/features/utils/constants.dart';

class CategoryFilter extends StatefulWidget {
  const CategoryFilter({super.key});

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  final categories = Constants().categories;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final defaultCategory = context.read<HomeBloc>().defaultCategory;
              final item = categories[index];
              final selectedCategory = state is HomeSuccessState
                  ? state.selectedCategory
                  : defaultCategory;
              return GestureDetector(
                onTap: () => context.read<HomeBloc>().add(
                      FilterCountryAndCategoryEvent(
                        category: item,
                        filterType: AppTexts.category,
                      ),
                    ),
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: selectedCategory == item
                        ? AppColors.primary
                        : AppColors.textFieldColor,
                  ),
                  child: Text(
                    item,
                    style: AppTextStyles.body16W400.copyWith(
                      color: selectedCategory == item
                          ? AppColors.white
                          : AppColors.black,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
