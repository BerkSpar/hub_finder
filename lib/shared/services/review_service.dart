import 'dart:async';
import 'package:in_app_review/in_app_review.dart';

class ReviewService {
  static final InAppReview inAppReview = InAppReview.instance;

  static void showReview() async {
    await Future.delayed(Duration(minutes: 5));

    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }
}
