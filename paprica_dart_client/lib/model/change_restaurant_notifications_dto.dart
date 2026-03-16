part of swagger.api;

class ChangeRestaurantNotificationsDto {
  int restaurantId = null;

  bool isNotificationsOn = null;

  ChangeRestaurantNotificationsDto();

  @override
  String toString() {
    return 'ChangeRestaurantNotificationsDto[restaurantId=$restaurantId, isNotificationsOn=$isNotificationsOn,]';
  }

  ChangeRestaurantNotificationsDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    restaurantId = json['restaurantId'];
    isNotificationsOn = json['isNotificationsOn'];
  }

  Map<String, dynamic> toJson() {
    return {
      'restaurantId': restaurantId,
      'isNotificationsOn': isNotificationsOn,
    };
  }

  static List<ChangeRestaurantNotificationsDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<ChangeRestaurantNotificationsDto>()
        : json
            .map(
                (value) => new ChangeRestaurantNotificationsDto.fromJson(value))
            .toList();
  }

  static Map<String, ChangeRestaurantNotificationsDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ChangeRestaurantNotificationsDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ChangeRestaurantNotificationsDto.fromJson(value));
    }
    return map;
  }
}
