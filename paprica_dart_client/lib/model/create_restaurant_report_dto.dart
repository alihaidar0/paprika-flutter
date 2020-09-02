part of swagger.api;

class CreateRestaurantReportDto {
  int restuarantId = null;

  int reservationId = null;

  String description = null;

  CreateRestaurantReportDto();

  @override
  String toString() {
    return 'CreateRestaurantReportDto[restuarantId=$restuarantId, reservationId=$reservationId, description=$description, ]';
  }

  CreateRestaurantReportDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    restuarantId = json['restuarantId'];
    reservationId = json['reservationId'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      'restuarantId': restuarantId,
      'reservationId': reservationId,
      'description': description
    };
  }

  static List<CreateRestaurantReportDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CreateRestaurantReportDto>()
        : json
            .map((value) => new CreateRestaurantReportDto.fromJson(value))
            .toList();
  }

  static Map<String, CreateRestaurantReportDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CreateRestaurantReportDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CreateRestaurantReportDto.fromJson(value));
    }
    return map;
  }
}
