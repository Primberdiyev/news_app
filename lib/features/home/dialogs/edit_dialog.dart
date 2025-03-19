import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/ui_kit/custom_button.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import 'package:news_app/features/home/models/article_model.dart';
import 'package:news_app/features/home/widgets/cached_image_widget.dart';
import 'package:news_app/features/utils/app_colors.dart';
import 'package:news_app/features/utils/app_text_styles.dart';
import 'package:news_app/features/utils/app_texts.dart';
import 'package:news_app/features/utils/constants.dart';

class EditDialog extends StatefulWidget {
  const EditDialog({
    super.key,
    required this.article,
  });
  final Article article;
  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    titleEditingController.text = widget.article.title ?? "";
    descriptionController.text = widget.article.description ?? "";
    super.initState();
  }

  @override
  void dispose() {
    titleEditingController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedImageWidget(
              imageLink: widget.article.urlToImage ?? Constants.errorImageUrl,
              imageWidth: size.width - 20,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              AppTexts.title,
              style: AppTextStyles.head20W600,
            ),
            TextFormField(
              maxLines: null,
              controller: titleEditingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              AppTexts.description,
              style: AppTextStyles.head20W600,
            ),
            TextFormField(
              maxLines: null,
              controller: descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    buttonHeight: 40,
                    color: AppColors.textFieldColor,
                    text: AppTexts.cancel,
                    textColor: AppColors.black,
                    function: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: CustomButton(
                    buttonHeight: 40,
                    color: AppColors.primary,
                    text: AppTexts.save,
                    textColor: AppColors.white,
                    function: () {
                      final lastArticle = widget.article;
                      final currentArticle = lastArticle.copyWith(
                        title: titleEditingController.text,
                        description: descriptionController.text,
                      );
                      if (lastArticle != currentArticle) {
                        context.read<HomeBloc>().add(EditNewsEvent(
                            lastArticle: lastArticle,
                            editedArticle: currentArticle));
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
