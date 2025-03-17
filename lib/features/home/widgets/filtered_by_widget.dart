import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import 'package:news_app/features/utils/app_colors.dart';
import 'package:news_app/features/utils/app_images.dart';
import 'package:news_app/features/utils/app_text_styles.dart';
import 'package:news_app/features/utils/app_texts.dart';

class FilteredByWidget extends StatefulWidget {
  const FilteredByWidget({super.key});

  @override
  State<FilteredByWidget> createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FilteredByWidget> {
  List<String> filters = [AppTexts.country, AppTexts.category];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccessState) {
          return Row(
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
              Text(AppTexts.filteredBy, style: AppTextStyles.body16W400),
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
                  context.read<HomeBloc>().add(
                      ChangeFilterTypeEvent(newValue ?? AppTexts.category));
                },
              )
            ],
          );
        }
        return SizedBox();
      },
    );
  }
}
