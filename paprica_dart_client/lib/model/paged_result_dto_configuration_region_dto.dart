part of swagger.api;

class PagedResultDtoConfigurationRegionDto {
  int totalCount = null;

  List<ConfigurationRegionDto> items = [];

  PagedResultDtoConfigurationRegionDto();

  @override
  String toString() {
    return 'PagedResultDtoConfigurationRegionDto[totalCount=$totalCount, items=$items, ]';
  }

  PagedResultDtoConfigurationRegionDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    totalCount = json['totalCount'];
    items = ConfigurationRegionDto.listFromJson(json['items']);
  }

  Map<String, dynamic> toJson() {
    return {'totalCount': totalCount, 'items': items};
  }

  static List<PagedResultDtoConfigurationRegionDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<PagedResultDtoConfigurationRegionDto>()
        : json
            .map((value) =>
                new PagedResultDtoConfigurationRegionDto.fromJson(value))
            .toList();
  }

  static Map<String, PagedResultDtoConfigurationRegionDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PagedResultDtoConfigurationRegionDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PagedResultDtoConfigurationRegionDto.fromJson(value));
    }
    return map;
  }
}
