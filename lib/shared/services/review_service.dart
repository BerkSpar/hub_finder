import 'dart:async';
import 'package:hub_finder/shared/services/database_service.dart';
import 'package:in_app_review/in_app_review.dart';

class ReviewService {
  static final InAppReview inAppReview = InAppReview.instance;

  static void scheduleReview(
      [Duration waitTime = const Duration(seconds: 20)]) async {
    if (!(await LocalStorageService().showReview())) return;

    await Future.delayed(waitTime);

    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }

    LocalStorageService().saveReviewDate();
  }
}
