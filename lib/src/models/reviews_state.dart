import 'package:swagger/api.dart';

class ReviewsState {
  Future<RestaurantReviewsSummaryDto> summary;

  ReviewDto customerReview;

  ReviewsState({this.summary, this.customerReview});
}
