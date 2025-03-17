import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import 'package:news_app/features/utils/app_colors.dart';
import 'package:news_app/features/utils/app_text_styles.dart';
import 'package:news_app/features/utils/app_texts.dart';
import 'package:news_app/features/utils/country_filter_components.dart';

class FiltersCountry extends StatefulWidget {
  const FiltersCountry({
    super.key,
  });
  @override
  State<FiltersCountry> createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FiltersCountry> {
  final countryComponents = CountryFilterComponents().countryComponents;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return SizedBox(
          height: 70,
          child: ListView.builder(
            itemCount: countryComponents.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final defaultCountry = context.read<HomeBloc>().defaultCountry;
              final item = countryComponents[index];
              final selectedCountry = state is HomeSuccessState
                  ? state.selectedCountry
                  : defaultCountry;
              return GestureDetector(
                onTap: () => context.read<HomeBloc>().add(
                      GetNewsEvent(country: item, filterType: AppTexts.country),
                    ),
                child: Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: selectedCountry?.name == item.name
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
                          color: selectedCountry?.name == item.name
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
        );
      },
    );
  }
}
