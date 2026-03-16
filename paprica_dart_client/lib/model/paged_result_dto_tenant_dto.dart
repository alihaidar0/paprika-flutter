part of swagger.api;

class PagedResultDtoTenantDto {
  int totalCount = null;

  List<TenantDto> items = [];

  PagedResultDtoTenantDto();

  @override
  String toString() {
    return 'PagedResultDtoTenantDto[totalCount=$totalCount, items=$items, ]';
  }

  PagedResultDtoTenantDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    totalCount = json['totalCount'];
    items = TenantDto.listFromJson(json['items']);
  }

  Map<String, dynamic> toJson() {
    return {'totalCount': totalCount, 'items': items};
  }

  static List<PagedResultDtoTenantDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PagedResultDtoTenantDto>()
        : json
            .map((value) => new PagedResultDtoTenantDto.fromJson(value))
            .toList();
  }

  static Map<String, PagedResultDtoTenantDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PagedResultDtoTenantDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PagedResultDtoTenantDto.fromJson(value));
    }
    return map;
  }
}
