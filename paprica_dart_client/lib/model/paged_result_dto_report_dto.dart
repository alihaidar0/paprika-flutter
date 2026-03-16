part of swagger.api;

class PagedResultDtoReportDto {
  int totalCount = null;

  List<ReportDto> items = [];

  PagedResultDtoReportDto();

  @override
  String toString() {
    return 'PagedResultDtoReportDto[totalCount=$totalCount, items=$items, ]';
  }

  PagedResultDtoReportDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    totalCount = json['totalCount'];
    items = ReportDto.listFromJson(json['items']);
  }

  Map<String, dynamic> toJson() {
    return {'totalCount': totalCount, 'items': items};
  }

  static List<PagedResultDtoReportDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PagedResultDtoReportDto>()
        : json
            .map((value) => new PagedResultDtoReportDto.fromJson(value))
            .toList();
  }

  static Map<String, PagedResultDtoReportDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PagedResultDtoReportDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PagedResultDtoReportDto.fromJson(value));
    }
    return map;
  }
}
