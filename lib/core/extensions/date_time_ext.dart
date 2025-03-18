import 'package:news_app/features/utils/app_texts.dart';

extension DateTimeExt on String {
  String getTimeAgo() {
    final dateTime = DateTime.tryParse(this);
    if (dateTime == null) {
      return AppTexts.invalidTime;
    }
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    if (difference.inSeconds < 60) {
      return "$difference seconds ago";
    } else if (difference.inMinutes < 60) {
      return "$difference minutes ago";
    } else if (difference.inHours < 24) {
      return "$difference hours ago";
    }

    return "${difference.inDays} day ago";
  }
}
