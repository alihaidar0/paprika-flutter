part of swagger.api;

class CreatePickupDto {
  int restaurantId = null;

  DateTime time = null;

  List<CreatePickupMealDto> pickupMeals = [];

  CreatePickupDto();

  @override
  String toString() {
    return 'CreatePickupDto[restaurantId=$restaurantId, time=$time, pickupMeals=$pickupMeals]';
  }

  CreatePickupDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    restaurantId = json['restaurantId'];
    time = json['time'] == null ? null : DateTime.parse(json['time']);
    pickupMeals = CreatePickupMealDto.listFromJson(json['pickupMeals']);
  }

  Map<String, dynamic> toJson() {
    return {
      'restaurantId': restaurantId,
      'time': time == null ? '' : time.toUtc().toIso8601String(),
      'pickupMeals': pickupMeals,
    };
  }

  static List<CreatePickupDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CreatePickupDto>()
        : json
        .map((value) => new CreatePickupDto.fromJson(value))
        .toList();
  }

  static Map<String, CreatePickupDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CreatePickupDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new CreatePickupDto.fromJson(value));
    }
    return map;
  }
}
