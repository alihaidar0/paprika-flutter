part of swagger.api;

class RestaurantReviewsSummaryDto {
  
  List<ReviewSummaryDto> reviews = [];
  

  ReviewDto customerReview = null;
  

  String customerProfileImage = null;
  
  RestaurantReviewsSummaryDto();

  @override
  String toString() {
    return 'RestaurantReviewsSummaryDto[reviews=$reviews, customerReview=$customerReview, customerProfileImage=$customerProfileImage, ]';
  }

  RestaurantReviewsSummaryDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    reviews =
      ReviewSummaryDto.listFromJson(json['reviews'])
;
    customerReview =
      
      
      new ReviewDto.fromJson(json['customerReview'])
;
    customerProfileImage =
        json['customerProfileImage']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'reviews': reviews,
      'customerReview': customerReview,
      'customerProfileImage': customerProfileImage
     };
  }

  static List<RestaurantReviewsSummaryDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<RestaurantReviewsSummaryDto>() : json.map((value) => new RestaurantReviewsSummaryDto.fromJson(value)).toList();
  }

  static Map<String, RestaurantReviewsSummaryDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RestaurantReviewsSummaryDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new RestaurantReviewsSummaryDto.fromJson(value));
    }
    return map;
  }
}

