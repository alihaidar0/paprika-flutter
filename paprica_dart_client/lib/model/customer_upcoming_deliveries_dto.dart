part of swagger.api;

class CustomerUpcomingDeliveriesDto {
  List<CustomerUpcomingDeliveryDto> upcoming = [];

  int totalCount = null;

  CustomerUpcomingDeliveriesDto();

  @override
  String toString() {
    return 'CustomerUpcomingDeliveriesDto[upcoming=$upcoming, totalCount=$totalCount, ]';
  }

  CustomerUpcomingDeliveriesDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    upcoming = CustomerUpcomingDeliveryDto.listFromJson(json['upcoming']);
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    return {'upcoming': upcoming, 'totalCount': totalCount};
  }

  static List<CustomerUpcomingDeliveriesDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<CustomerUpcomingDeliveriesDto>()
        : json
        .map((value) => new CustomerUpcomingDeliveriesDto.fromJson(value))
        .toList();
  }

  static Map<String, CustomerUpcomingDeliveriesDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerUpcomingDeliveriesDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new CustomerUpcomingDeliveriesDto.fromJson(value));
    }
    return map;
  }
}
