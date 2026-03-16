part of swagger.api;

class PagedResultDtoServiceDto {
  int totalCount = null;

  List<ServiceDto> items = [];

  PagedResultDtoServiceDto();

  @override
  String toString() {
    return 'PagedResultDtoServiceDto[totalCount=$totalCount, items=$items, ]';
  }

  PagedResultDtoServiceDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    totalCount = json['totalCount'];
    items = ServiceDto.listFromJson(json['items']);
  }

  Map<String, dynamic> toJson() {
    return {'totalCount': totalCount, 'items': items};
  }

  static List<PagedResultDtoServiceDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PagedResultDtoServiceDto>()
        : json
            .map((value) => new PagedResultDtoServiceDto.fromJson(value))
            .toList();
  }

  static Map<String, PagedResultDtoServiceDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PagedResultDtoServiceDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PagedResultDtoServiceDto.fromJson(value));
    }
    return map;
  }
}
