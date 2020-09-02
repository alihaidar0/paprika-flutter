part of swagger.api;

class PagedResultDtoCustomerDto {
  int totalCount = null;

  List<CustomerDto> items = [];

  PagedResultDtoCustomerDto();

  @override
  String toString() {
    return 'PagedResultDtoCustomerDto[totalCount=$totalCount, items=$items, ]';
  }

  PagedResultDtoCustomerDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    totalCount = json['totalCount'];
    items = CustomerDto.listFromJson(json['items']);
  }

  Map<String, dynamic> toJson() {
    return {'totalCount': totalCount, 'items': items};
  }

  static List<PagedResultDtoCustomerDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PagedResultDtoCustomerDto>()
        : json
            .map((value) => new PagedResultDtoCustomerDto.fromJson(value))
            .toList();
  }

  static Map<String, PagedResultDtoCustomerDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PagedResultDtoCustomerDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PagedResultDtoCustomerDto.fromJson(value));
    }
    return map;
  }
}
