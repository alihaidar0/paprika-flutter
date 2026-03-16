part of swagger.api;

class PagedResultDtoRestaurantSummaryDto {
  int totalCount = null;

  List<RestaurantSummaryDto> items = [];

  PagedResultDtoRestaurantSummaryDto();

  @override
  String toString() {
    return 'PagedResultDtoRestaurantSummaryDto[totalCount=$totalCount, items=$items, ]';
  }

  PagedResultDtoRestaurantSummaryDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    totalCount = json['totalCount'];
    items = RestaurantSummaryDto.listFromJson(json['items']);
  }

  Map<String, dynamic> toJson() {
    return {'totalCount': totalCount, 'items': items};
  }

  static List<PagedResultDtoRestaurantSummaryDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<PagedResultDtoRestaurantSummaryDto>()
        : json
            .map((value) =>
                new PagedResultDtoRestaurantSummaryDto.fromJson(value))
            .toList();
  }

  static Map<String, PagedResultDtoRestaurantSummaryDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PagedResultDtoRestaurantSummaryDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PagedResultDtoRestaurantSummaryDto.fromJson(value));
    }
    return map;
  }
}
