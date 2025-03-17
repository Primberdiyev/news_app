import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import 'package:news_app/features/home/widgets/action_button.dart';
import 'package:news_app/features/home/widgets/category_filter.dart';
import 'package:news_app/features/home/widgets/failure_widget.dart';
import 'package:news_app/features/home/widgets/filtered_by_widget.dart';
import 'package:news_app/features/home/widgets/filters_country.dart';
import 'package:news_app/features/home/widgets/loading_widget.dart';
import 'package:news_app/features/home/widgets/news_item.dart';
import 'package:news_app/features/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  FilteredByWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  state.selectedCountry != null
                      ? FiltersCountry()
                      : CategoryFilter(),
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
