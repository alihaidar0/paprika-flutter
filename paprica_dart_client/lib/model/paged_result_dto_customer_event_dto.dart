part of swagger.api;

class PagedResultDtoCustomerEventDto {
  int totalCount = null;

  List<CustomerEventDto> items = [];

  PagedResultDtoCustomerEventDto();

  @override
  String toString() {
    return 'PagedResultDtoCustomerEventDto[totalCount=$totalCount, items=$items, ]';
  }

  PagedResultDtoCustomerEventDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    totalCount = json['totalCount'];
    items = CustomerEventDto.listFromJson(json['items']);
  }

  Map<String, dynamic> toJson() {
    return {'totalCount': totalCount, 'items': items};
  }

  static List<PagedResultDtoCustomerEventDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PagedResultDtoCustomerEventDto>()
        : json
            .map((value) => new PagedResultDtoCustomerEventDto.fromJson(value))
            .toList();
  }

  static Map<String, PagedResultDtoCustomerEventDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PagedResultDtoCustomerEventDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PagedResultDtoCustomerEventDto.fromJson(value));
    }
    return map;
  }
}
