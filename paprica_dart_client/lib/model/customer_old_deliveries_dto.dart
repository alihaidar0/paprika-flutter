part of swagger.api;

class CustomerOldDeliveriesDto {
  List<CustomerOldDeliveryDto> oldDeliveries = [];

  int totalCount = null;

  CustomerOldDeliveriesDto();

  @override
  String toString() {
    return 'CustomerOldDeliveriesDto[oldPickups=$oldDeliveries, totalCount=$totalCount, ]';
  }

  CustomerOldDeliveriesDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    oldDeliveries =
        CustomerOldDeliveryDto.listFromJson(json['oldDeliveries']);
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    return {'oldDeliveries': oldDeliveries, 'totalCount': totalCount};
  }

  static List<CustomerOldDeliveriesDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CustomerOldDeliveriesDto>()
        : json
        .map((value) => new CustomerOldDeliveriesDto.fromJson(value))
        .toList();
  }

  static Map<String, CustomerOldDeliveriesDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerOldDeliveriesDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new CustomerOldDeliveriesDto.fromJson(value));
    }
    return map;
  }
}
