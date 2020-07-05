part of swagger.api;

class PagedResultDtoManagerOfferDto {
  
  int totalCount = null;
  

  List<ManagerOfferDto> items = [];
  
  PagedResultDtoManagerOfferDto();

  @override
  String toString() {
    return 'PagedResultDtoManagerOfferDto[totalCount=$totalCount, items=$items, ]';
  }

  PagedResultDtoManagerOfferDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    totalCount =
        json['totalCount']
    ;
    items =
      ManagerOfferDto.listFromJson(json['items'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'totalCount': totalCount,
      'items': items
     };
  }

  static List<PagedResultDtoManagerOfferDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<PagedResultDtoManagerOfferDto>() : json.map((value) => new PagedResultDtoManagerOfferDto.fromJson(value)).toList();
  }

  static Map<String, PagedResultDtoManagerOfferDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PagedResultDtoManagerOfferDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new PagedResultDtoManagerOfferDto.fromJson(value));
    }
    return map;
  }
}

