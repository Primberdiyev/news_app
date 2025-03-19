import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import 'package:news_app/features/utils/app_colors.dart';
import 'package:news_app/features/utils/app_text_styles.dart';
import 'package:news_app/features/utils/sort_components.dart';

class SelectCategory extends StatelessWidget {
  const SelectCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final items = SortComponents.categories;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return SizedBox(
          height: 70,
          child: ListView.builder(
            itemCount: items.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final item = items[index];
              final bool isSelected = ((state is HomeSuccessState)
                      ? state.selectedCategory
                      : items.first) ==
                  item;
              return GestureDetector(
                onTap: () {
                  context.read<HomeBloc>().add(ChangeCategoryEvent(item));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textFieldColor,
                  ),
                  child: Row(
                    children: [
                      Text(
                        item,
                        style: AppTextStyles.body16W400.copyWith(
                          color: isSelected ? AppColors.white : AppColors.black,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
