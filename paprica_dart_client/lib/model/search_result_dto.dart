part of swagger.api;

class SearchResultDto {
  
  List<LiteSearchItemDto> meals = [];
  

  List<LiteSearchItemDto> restaurants = [];
  

  List<LiteSearchItemDto> events = [];
  
  SearchResultDto();

  @override
  String toString() {
    return 'SearchResultDto[meals=$meals, restaurants=$restaurants, events=$events, ]';
  }

  SearchResultDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    meals =
      LiteSearchItemDto.listFromJson(json['meals'])
;
    restaurants =
      LiteSearchItemDto.listFromJson(json['restaurants'])
;
    events =
      LiteSearchItemDto.listFromJson(json['events'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'meals': meals,
      'restaurants': restaurants,
      'events': events
     };
  }

  static List<SearchResultDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<SearchResultDto>() : json.map((value) => new SearchResultDto.fromJson(value)).toList();
  }

  static Map<String, SearchResultDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SearchResultDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new SearchResultDto.fromJson(value));
    }
    return map;
  }
}

