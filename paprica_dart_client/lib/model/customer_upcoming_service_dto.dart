part of swagger.api;


class CustomerUpcomingServiceDto {
  int pickupsTotalCount = null;

  int reservationsTotalCount = null;

  int deliveriesTotalCount = null;

  CustomerNearestPickupDto nearestPickup = null;

  CustomerNearestReservationDto nearestReservation = null;

  CustomerNearestDeliveryDto nearestDelivery = null;

  CustomerUpcomingServiceDto();

  @override
  String toString() {
    return 'CustomerAllUpcomingDto[pickupsTotalCount=$pickupsTotalCount, reservationsTotalCount=$reservationsTotalCount, deliveriesTotalCount=$deliveriesTotalCount, nearestPickup=$nearestPickup, nearestReservation=$nearestReservation, nearestDelivery=$nearestDelivery ]';
  }

  CustomerUpcomingServiceDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    pickupsTotalCount = json['pickupsTotalCount'];
    reservationsTotalCount = json['reservationsTotalCount'];
    deliveriesTotalCount = json['deliveriesTotalCount'];
    nearestPickup = json['nearestPickup'] == null
        ? null
        : new CustomerNearestPickupDto.fromJson(json['nearestPickup']);
    nearestReservation = json['nearestReservation'] == null
        ? null
        : new CustomerNearestReservationDto.fromJson(json['nearestReservation']);
    nearestDelivery = json['nearestDelivery'] == null
        ? null
        : new CustomerNearestDeliveryDto.fromJson(json['nearestDelivery']);
  }

  Map<String, dynamic> toJson() {
    return {'pickupsTotalCount': pickupsTotalCount, 'reservationsTotalCount': reservationsTotalCount, 'deliveriesTotalCount': deliveriesTotalCount, 'nearestPickup': nearestPickup, 'nearestReservation': nearestReservation};
  }

  static List<CustomerUpcomingServiceDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<CustomerUpcomingServiceDto>()
        : json
        .map((value) => new CustomerUpcomingServiceDto.fromJson(value))
        .toList();
  }

  static Map<String, CustomerUpcomingServiceDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerUpcomingServiceDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new CustomerUpcomingServiceDto.fromJson(value));
    }
    return map;
  }
}
