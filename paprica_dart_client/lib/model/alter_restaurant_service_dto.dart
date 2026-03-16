part of swagger.api;

class AlterRestaurantServiceDto {
  int restaurantId = null;

  int serviceId = null;

  AlterRestaurantServiceDto();

  @override
  String toString() {
    return 'AlterRestaurantServiceDto[restaurantId=$restaurantId, serviceId=$serviceId, ]';
  }

  AlterRestaurantServiceDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    restaurantId = json['restaurantId'];
    serviceId = json['serviceId'];
  }

  Map<String, dynamic> toJson() {
    return {'restaurantId': restaurantId, 'serviceId': serviceId};
  }

  static List<AlterRestaurantServiceDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<AlterRestaurantServiceDto>()
        : json
            .map((value) => new AlterRestaurantServiceDto.fromJson(value))
            .toList();
  }

  static Map<String, AlterRestaurantServiceDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AlterRestaurantServiceDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AlterRestaurantServiceDto.fromJson(value));
    }
    return map;
  }
}
