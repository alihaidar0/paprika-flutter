part of swagger.api;

class CustomerOldPickupsDto {
  List<CustomerOldPickupDto> oldPickups = [];

  int totalCount = null;

  CustomerOldPickupsDto();

  @override
  String toString() {
    return 'CustomerOldPickupsDto[oldPickups=$oldPickups, totalCount=$totalCount, ]';
  }

  CustomerOldPickupsDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    oldPickups =
        CustomerOldPickupDto.listFromJson(json['oldPickups']);
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    return {'oldPickups': oldPickups, 'totalCount': totalCount};
  }

  static List<CustomerOldReservationsDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CustomerOldReservationsDto>()
        : json
        .map((value) => new CustomerOldReservationsDto.fromJson(value))
        .toList();
  }

  static Map<String, CustomerOldReservationsDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerOldReservationsDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new CustomerOldReservationsDto.fromJson(value));
    }
    return map;
  }
}
