import 'package:swagger/api.dart';

class ReviewCommentModel {
  String customerProfileImage, customerFullName, comment;
  double rate;

  ReviewCommentModel({
    this.customerProfileImage,
    this.customerFullName,
    this.comment,
    this.rate,
  });

  ReviewCommentModel.fromReviewSummaryDto(ReviewSummaryDto reviewSummaryDto) {
    customerFullName = reviewSummaryDto.customerFullName;
    customerProfileImage = reviewSummaryDto.customerProfileImage;
    comment = reviewSummaryDto.comment;
    rate = reviewSummaryDto.rate;
  }

//  reviewComment.fromReviewDto(ReviewDto reviewDto) {
//    customerFullName = reviewDto.;
//    customerProfileImage = reviewSummaryDto.customerProfileImage;
//    comment = reviewSummaryDto.comment;
//    rate = reviewSummaryDto.rate;
//  }

}
