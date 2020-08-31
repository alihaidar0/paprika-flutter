part of swagger.api;

class PagedResultDtoConfigurationCityDto {
  int totalCount = null;

  List<ConfigurationCityDto> items = [];

  PagedResultDtoConfigurationCityDto();

  @override
  String toString() {
    return 'PagedResultDtoConfigurationCityDto[totalCount=$totalCount, items=$items, ]';
  }

  PagedResultDtoConfigurationCityDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    totalCount = json['totalCount'];
    items = ConfigurationCityDto.listFromJson(json['items']);
  }

  Map<String, dynamic> toJson() {
    return {'totalCount': totalCount, 'items': items};
  }

  static List<PagedResultDtoConfigurationCityDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<PagedResultDtoConfigurationCityDto>()
        : json
            .map((value) =>
                new PagedResultDtoConfigurationCityDto.fromJson(value))
            .toList();
  }

  static Map<String, PagedResultDtoConfigurationCityDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PagedResultDtoConfigurationCityDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PagedResultDtoConfigurationCityDto.fromJson(value));
    }
    return map;
  }
}
