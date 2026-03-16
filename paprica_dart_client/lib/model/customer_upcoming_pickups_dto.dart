part of swagger.api;

class CustomerUpcomingPickupsDto {
  List<CustomerUpcomingPickupDto> upcoming = [];

  int totalCount = null;

  CustomerUpcomingPickupsDto();

  @override
  String toString() {
    return 'CustomerUpcomingReservationsDto[upcoming=$upcoming, totalCount=$totalCount, ]';
  }

  CustomerUpcomingPickupsDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    upcoming = CustomerUpcomingPickupDto.listFromJson(json['upcoming']);
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    return {'upcoming': upcoming, 'totalCount': totalCount};
  }

  static List<CustomerUpcomingPickupsDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<CustomerUpcomingPickupsDto>()
        : json
        .map((value) => new CustomerUpcomingPickupsDto.fromJson(value))
        .toList();
  }

  static Map<String, CustomerUpcomingPickupsDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerUpcomingPickupsDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new CustomerUpcomingPickupsDto.fromJson(value));
    }
    return map;
  }
}
