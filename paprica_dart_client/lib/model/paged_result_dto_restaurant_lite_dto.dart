part of swagger.api;

class PagedResultDtoRestaurantLiteDto {
  int totalCount = null;

  List<RestaurantLiteDto> items = [];

  PagedResultDtoRestaurantLiteDto();

  @override
  String toString() {
    return 'PagedResultDtoRestaurantLiteDto[totalCount=$totalCount, items=$items, ]';
  }

  PagedResultDtoRestaurantLiteDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    totalCount = json['totalCount'];
    items = RestaurantLiteDto.listFromJson(json['items']);
  }

  Map<String, dynamic> toJson() {
    return {'totalCount': totalCount, 'items': items};
  }

  static List<PagedResultDtoRestaurantLiteDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<PagedResultDtoRestaurantLiteDto>()
        : json
            .map((value) => new PagedResultDtoRestaurantLiteDto.fromJson(value))
            .toList();
  }

  static Map<String, PagedResultDtoRestaurantLiteDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PagedResultDtoRestaurantLiteDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PagedResultDtoRestaurantLiteDto.fromJson(value));
    }
    return map;
  }
}
