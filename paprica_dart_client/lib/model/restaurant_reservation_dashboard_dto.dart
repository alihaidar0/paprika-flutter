part of swagger.api;

class RestaurantReservationDashboardDto {
  int pendingReservationsCount = null;

  int todayReservationsCount = null;

  int rejectedReservationsCount = null;

  int upcomingReservationsCount = null;

  RestaurantReservationDashboardDto();

  @override
  String toString() {
    return 'RestaurantReservationDashboardDto[pendingReservationsCount=$pendingReservationsCount, todayReservationsCount=$todayReservationsCount, rejectedReservationsCount=$rejectedReservationsCount, upcomingReservationsCount=$upcomingReservationsCount, ]';
  }

  RestaurantReservationDashboardDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    pendingReservationsCount = json['pendingReservationsCount'];
    todayReservationsCount = json['todayReservationsCount'];
    rejectedReservationsCount = json['rejectedReservationsCount'];
    upcomingReservationsCount = json['upcomingReservationsCount'];
  }

  Map<String, dynamic> toJson() {
    return {
      'pendingReservationsCount': pendingReservationsCount,
      'todayReservationsCount': todayReservationsCount,
      'rejectedReservationsCount': rejectedReservationsCount,
      'upcomingReservationsCount': upcomingReservationsCount
    };
  }

  static List<RestaurantReservationDashboardDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<RestaurantReservationDashboardDto>()
        : json
            .map((value) =>
                new RestaurantReservationDashboardDto.fromJson(value))
            .toList();
  }

  static Map<String, RestaurantReservationDashboardDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RestaurantReservationDashboardDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new RestaurantReservationDashboardDto.fromJson(value));
    }
    return map;
  }
}
