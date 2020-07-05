part of swagger.api;

class PagedResultDtoManagerEventDto {
  
  int totalCount = null;
  

  List<ManagerEventDto> items = [];
  
  PagedResultDtoManagerEventDto();

  @override
  String toString() {
    return 'PagedResultDtoManagerEventDto[totalCount=$totalCount, items=$items, ]';
  }

  PagedResultDtoManagerEventDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    totalCount =
        json['totalCount']
    ;
    items =
      ManagerEventDto.listFromJson(json['items'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'totalCount': totalCount,
      'items': items
     };
  }

  static List<PagedResultDtoManagerEventDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<PagedResultDtoManagerEventDto>() : json.map((value) => new PagedResultDtoManagerEventDto.fromJson(value)).toList();
  }

  static Map<String, PagedResultDtoManagerEventDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PagedResultDtoManagerEventDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new PagedResultDtoManagerEventDto.fromJson(value));
    }
    return map;
  }
}

