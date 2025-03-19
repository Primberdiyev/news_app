import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import 'package:news_app/features/utils/app_colors.dart';
import 'package:news_app/features/utils/app_text_styles.dart';
import 'package:news_app/features/utils/app_texts.dart';

class SortWidget extends StatelessWidget {
  const SortWidget({
    super.key,
    required this.items,
    this.selectedItem,
    required this.isCountry,
    required this.function,
  });
  final List items;
  final dynamic selectedItem;
  final bool isCountry;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = items[index];
          final isSelected = isCountry
              ? selectedItem?.name == item.name
              : selectedItem == item;
          return GestureDetector(
            onTap: () {
              context.read<HomeBloc>().add(
                    GetNewsEvent(
                      filterType:
                          isCountry ? AppTexts.country : AppTexts.category,
                      categoryName: !isCountry ? item : null,
                      country: isCountry ? item : null,
                    ),
                  );
            },
            child: Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:
                    isSelected ? AppColors.primary : AppColors.textFieldColor,
              ),
              child: Row(
                children: [
                  if (isCountry)
                    Row(
                      children: [
                        Image.asset(
                          item.imageAsset,
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  Text(
                    isCountry ? item.name : item,
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
  }
}
