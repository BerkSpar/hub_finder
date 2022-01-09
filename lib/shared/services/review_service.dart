import 'dart:async';
import 'package:hub_finder/shared/services/database_service.dart';
import 'package:in_app_review/in_app_review.dart';

class ReviewService {
  static final InAppReview inAppReview = InAppReview.instance;

  static void showReview() async {
    if (!(await LocalStorageService().showReview())) return;

    await Future.delayed(Duration(seconds: 10));

    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }

    LocalStorageService().saveReviewDate();
  }
}
