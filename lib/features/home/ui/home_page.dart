import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import 'package:news_app/features/home/repositories/database.dart';
import 'package:news_app/features/home/widgets/news_item.dart';
import 'package:news_app/features/home/widgets/search_news.dart';
import 'package:news_app/features/utils/app_colors.dart';
import 'package:news_app/features/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc homeBloc;
  @override
  void initState() {
    homeBloc = HomeBloc();
    homeBloc.add(GetNewsEvent());
    super.initState();
  }

  @override
  void dispose() {
    homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listener: (context, state) {
        if (state is HomeErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is HomeLoadingState
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.blue,
                  ),
                )
              : (state is HomeSuccessState)
                  ? Column(
                      children: [
                        SearchNews(
                          news: state.articles,
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: (state).articles.length,
                            itemBuilder: (context, index) {
                              final newData = state.articles[index];
                              return NewsItem(
                                  imageUrl: newData.urlToImage ??
                                      Constants.errorImageUrl,
                                  title: newData.title ?? '',
                                  time: newData.publishedAt ?? '',
                                  description: newData.description ?? "",
                                  url: newData.url ?? '');
                            },
                          ),
                        ),
                      ],
                    )
                  : SizedBox(),
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.delete,
              color: AppColors.red,
            ),
            onPressed: () async {
              await Database().clearDatabase();
            },
          ),
        );
      },
    );
  }
}
