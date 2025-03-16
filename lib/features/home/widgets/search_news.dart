import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import 'package:news_app/features/home/models/article_model.dart';
import 'package:news_app/features/home/models/country_model.dart';
import 'package:news_app/features/utils/app_colors.dart';
import 'package:news_app/features/utils/country_filter_components.dart';

class SearchNews extends StatefulWidget {
  const SearchNews({super.key, required this.news});
  final List<Article> news;

  @override
  State<SearchNews> createState() => _SearchNewsState();
}

class _SearchNewsState extends State<SearchNews> {
  final TextEditingController controller = TextEditingController();
  final CountryFilterComponents countryComponents = CountryFilterComponents();
  Timer? _debounce;

  @override
  void dispose() {
    controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(Duration(milliseconds: 500), () {
      context.read<HomeBloc>().add(FilterNewsEvent(value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80, right: 20, left: 20, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: (value) => _onSearchChanged(value),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.darkgrey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              final selectedCountry = (state is HomeSuccessState)
                  ? state.selectedCountry
                  : countryComponents.countryComponents.last;
              return DropdownButton<CountryModel>(
                value: countryComponents.countryComponents.firstWhere(
                    (element) => element == selectedCountry,
                    orElse: () => countryComponents.countryComponents.last),
                items: countryComponents.countryComponents
                    .map((CountryModel value) {
                  return DropdownMenuItem(
                    value: value,
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
              );
            },
          ),
        ],
      ),
    );
  }
}
