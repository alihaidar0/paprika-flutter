part of swagger.api;

class PagedResultDtoVisitorContactInfoDto {
  int totalCount = null;

  List<VisitorContactInfoDto> items = [];

  PagedResultDtoVisitorContactInfoDto();

  @override
  String toString() {
    return 'PagedResultDtoVisitorContactInfoDto[totalCount=$totalCount, items=$items, ]';
  }

  PagedResultDtoVisitorContactInfoDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    totalCount = json['totalCount'];
    items = VisitorContactInfoDto.listFromJson(json['items']);
  }

  Map<String, dynamic> toJson() {
    return {'totalCount': totalCount, 'items': items};
  }

  static List<PagedResultDtoVisitorContactInfoDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<PagedResultDtoVisitorContactInfoDto>()
        : json
            .map((value) =>
                new PagedResultDtoVisitorContactInfoDto.fromJson(value))
            .toList();
  }

  static Map<String, PagedResultDtoVisitorContactInfoDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PagedResultDtoVisitorContactInfoDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PagedResultDtoVisitorContactInfoDto.fromJson(value));
    }
    return map;
  }
}
