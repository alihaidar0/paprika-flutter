part of swagger.api;

class RestaurantReportDto {
  int reportId = null;

  int reservationId = null;

  int id = null;

  RestaurantReportDto();

  @override
  String toString() {
    return 'RestaurantReportDto[reportId=$reportId, reservationId=$reservationId, id=$id, ]';
  }

  RestaurantReportDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    reportId = json['reportId'];
    reservationId = json['reservationId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {'reportId': reportId, 'reservationId': reservationId, 'id': id};
  }

  static List<RestaurantReportDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<RestaurantReportDto>()
        : json.map((value) => new RestaurantReportDto.fromJson(value)).toList();
  }

  static Map<String, RestaurantReportDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RestaurantReportDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new RestaurantReportDto.fromJson(value));
    }
    return map;
  }
}
