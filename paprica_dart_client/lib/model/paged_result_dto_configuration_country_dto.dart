part of swagger.api;

class PagedResultDtoConfigurationCountryDto {
  
  int totalCount = null;
  

  List<ConfigurationCountryDto> items = [];
  
  PagedResultDtoConfigurationCountryDto();

  @override
  String toString() {
    return 'PagedResultDtoConfigurationCountryDto[totalCount=$totalCount, items=$items, ]';
  }

  PagedResultDtoConfigurationCountryDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    totalCount =
        json['totalCount']
    ;
    items =
      ConfigurationCountryDto.listFromJson(json['items'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'totalCount': totalCount,
      'items': items
     };
  }

  static List<PagedResultDtoConfigurationCountryDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<PagedResultDtoConfigurationCountryDto>() : json.map((value) => new PagedResultDtoConfigurationCountryDto.fromJson(value)).toList();
  }

  static Map<String, PagedResultDtoConfigurationCountryDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PagedResultDtoConfigurationCountryDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new PagedResultDtoConfigurationCountryDto.fromJson(value));
    }
    return map;
  }
}

