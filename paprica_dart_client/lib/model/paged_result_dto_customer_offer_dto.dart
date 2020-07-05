part of swagger.api;

class PagedResultDtoCustomerOfferDto {
  int totalCount = null;

  List<CustomerOfferDto> items = [];

  PagedResultDtoCustomerOfferDto();

  @override
  String toString() {
    return 'PagedResultDtoCustomerOfferDto[totalCount=$totalCount, items=$items, ]';
  }

  PagedResultDtoCustomerOfferDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    totalCount = json['totalCount'];
    items = CustomerOfferDto.listFromJson(json['items']);
  }

  Map<String, dynamic> toJson() {
    return {'totalCount': totalCount, 'items': items};
  }

  static List<PagedResultDtoCustomerOfferDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PagedResultDtoCustomerOfferDto>()
        : json
            .map((value) => new PagedResultDtoCustomerOfferDto.fromJson(value))
            .toList();
  }

  static Map<String, PagedResultDtoCustomerOfferDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PagedResultDtoCustomerOfferDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PagedResultDtoCustomerOfferDto.fromJson(value));
    }
    return map;
  }
}
