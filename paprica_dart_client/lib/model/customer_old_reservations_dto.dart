part of swagger.api;

class CustomerOldReservationsDto {
  List<CustomerOldReservationDto> oldReservations = [];

  int totalCount = null;

  CustomerOldReservationsDto();

  @override
  String toString() {
    return 'CustomerOldReservationsDto[oldReservations=$oldReservations, totalCount=$totalCount, ]';
  }

  CustomerOldReservationsDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    oldReservations =
        CustomerOldReservationDto.listFromJson(json['oldReservations']);
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    return {'oldReservations': oldReservations, 'totalCount': totalCount};
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
