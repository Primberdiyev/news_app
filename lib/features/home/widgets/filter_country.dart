import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import 'package:news_app/features/home/models/country_model.dart';
import 'package:news_app/features/utils/app_text_styles.dart';
import 'package:news_app/features/utils/country_filter_components.dart';

class FilterCountry extends StatefulWidget {
  const FilterCountry({super.key});

  @override
  State<FilterCountry> createState() => _FilterCountryState();
}

class _FilterCountryState extends State<FilterCountry> {
  final CountryFilterComponents countryComponents = CountryFilterComponents();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final defaultCountry = countryComponents.countryComponents.last;
        final CountryModel? selectedCountry = (state is HomeSuccessState)
            ? state.selectedCountry
            : defaultCountry;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${selectedCountry?.name ?? defaultCountry.name} news",
              style: AppTextStyles.body16W400.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Spacer(),
            DropdownButton<CountryModel>(
              alignment: Alignment.centerLeft,
              value: countryComponents.countryComponents.firstWhere(
                  (element) => element == selectedCountry,
                  orElse: () => countryComponents.countryComponents.last),
              items:
                  countryComponents.countryComponents.map((CountryModel value) {
                return DropdownMenuItem(
                  value: value,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Image.asset(
                        value.imageAsset,
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(value.name),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (CountryModel? newValue) {
                context.read<HomeBloc>().add(FilterCountryEvent(newValue));
              },
            ),
          ],
        );
      },
    );
  }
}
