part of swagger.api;

class PagedResultDtoRestaurantDto {
  
  int totalCount = null;
  

  List<RestaurantDto> items = [];
  
  PagedResultDtoRestaurantDto();

  @override
  String toString() {
    return 'PagedResultDtoRestaurantDto[totalCount=$totalCount, items=$items, ]';
  }

  PagedResultDtoRestaurantDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    totalCount =
        json['totalCount']
    ;
    items =
      RestaurantDto.listFromJson(json['items'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'totalCount': totalCount,
      'items': items
     };
  }

  static List<PagedResultDtoRestaurantDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<PagedResultDtoRestaurantDto>() : json.map((value) => new PagedResultDtoRestaurantDto.fromJson(value)).toList();
  }

  static Map<String, PagedResultDtoRestaurantDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PagedResultDtoRestaurantDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new PagedResultDtoRestaurantDto.fromJson(value));
    }
    return map;
  }
}

