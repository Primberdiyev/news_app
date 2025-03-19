import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/ui_kit/custom_button.dart';
import 'package:news_app/core/ui_kit/custom_text_field.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import 'package:news_app/features/home/models/article_model.dart';
import 'package:news_app/features/home/widgets/select_category.dart';
import 'package:news_app/features/utils/app_colors.dart';
import 'package:news_app/features/utils/app_images.dart';
import 'package:news_app/features/utils/app_text_styles.dart';
import 'package:news_app/features/utils/app_texts.dart';

class AddArticlePage extends StatefulWidget {
  const AddArticlePage({super.key});

  @override
  State<AddArticlePage> createState() => _AddArticleDialogState();
}

class _AddArticleDialogState extends State<AddArticlePage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final authorController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    authorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: ListView(
            padding: EdgeInsets.only(left: 20, right: 20, top: 50),
            children: [
              if (state is HomeSuccessState)
                GestureDetector(
                  onTap: () {
                    context.read<HomeBloc>().add(PickImageEvent());
                  },
                  child: CircleAvatar(
                    radius: 90,
                    backgroundImage: state.pickedImageLink != null
                        ? CachedNetworkImageProvider(
                            state.pickedImageLink ?? '',
                          )
                        : AssetImage(
                            AppImages.add.image,
                          ),
                  ),
                ),
              Text(
                AppTexts.title,
                style: AppTextStyles.head20W600,
              ),
              CustomTextField(
                controller: titleController,
                hintText: AppTexts.enterTitle,
                maxLine: 2,
                topPaddingSize: 0,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                AppTexts.description,
                style: AppTextStyles.head20W600,
              ),
              CustomTextField(
                controller: descriptionController,
                hintText: AppTexts.enterDescription,
                maxLine: 2,
                topPaddingSize: 0,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                AppTexts.author,
                style: AppTextStyles.head20W600,
              ),
              CustomTextField(
                controller: authorController,
                hintText: AppTexts.enterDescription,
                maxLine: 2,
                topPaddingSize: 0,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                AppTexts.category,
                style: AppTextStyles.head20W600,
              ),
              SelectCategory(),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    buttonHeight: 60,
                    color: AppColors.textFieldColor,
                    text: AppTexts.cancel,
                    textColor: AppColors.black,
                    function: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: CustomButton(
                    buttonHeight: 60,
                    color: AppColors.primary,
                    text: AppTexts.save,
                    textColor: AppColors.white,
                    function: () {
                      final newArticle = Article(
                        title: titleController.text,
                        description: descriptionController.text,
                        author: authorController.text,
                      
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
