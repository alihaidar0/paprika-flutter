part of swagger.api;

class PagedResultDtoReviewDto {
  int totalCount = null;

  List<ReviewSummaryDto> items = [];

  PagedResultDtoReviewDto();

  @override
  String toString() {
    return 'PagedResultDtoReviewDto[totalCount=$totalCount, items=$items, ]';
  }

  PagedResultDtoReviewDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    totalCount = json['totalCount'];
    items = ReviewSummaryDto.listFromJson(json['items']);
  }

  Map<String, dynamic> toJson() {
    return {'totalCount': totalCount, 'items': items};
  }

  static List<PagedResultDtoReviewDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PagedResultDtoReviewDto>()
        : json
            .map((value) => new PagedResultDtoReviewDto.fromJson(value))
            .toList();
  }

  static Map<String, PagedResultDtoReviewDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PagedResultDtoReviewDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PagedResultDtoReviewDto.fromJson(value));
    }
    return map;
  }
}
