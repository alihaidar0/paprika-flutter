part of swagger.api;

class ReviewSummaryDto {
  String customerProfileImage = null;

  String customerFullName = null;

  double rate = null;

  String comment = null;

  ReviewSummaryDto();

  @override
  String toString() {
    return 'ReviewSummaryDto[customerProfileImage=$customerProfileImage, customerFullName=$customerFullName, rate=$rate, comment=$comment, ]';
  }

  ReviewSummaryDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    customerProfileImage = json['customerProfileImage'];
    customerFullName = json['customerFullName'];
    rate = json['rate'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    return {
      'customerProfileImage': customerProfileImage,
      'customerFullName': customerFullName,
      'rate': rate,
      'comment': comment
    };
  }

  static List<ReviewSummaryDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ReviewSummaryDto>()
        : json.map((value) => new ReviewSummaryDto.fromJson(value)).toList();
  }

  static Map<String, ReviewSummaryDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ReviewSummaryDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ReviewSummaryDto.fromJson(value));
    }
    return map;
  }
}
