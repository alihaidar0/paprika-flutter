part of swagger.api;

class UpdatePickupDto {
  int id = null;

  DateTime time = null;

  List<UpdatePickupMealDto> pickupMeals = [];

  UpdatePickupDto();

  @override
  String toString() {
    return 'CreatePickupDto[id=$id, time=$time, pickupMeals=$pickupMeals]';
  }

  UpdatePickupDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    time = json['time'] == null ? null : DateTime.parse(json['time']);
    pickupMeals = UpdatePickupMealDto.listFromJson(json['pickupMeals']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'time': time == null ? '' : time.toUtc().toIso8601String(),
      'pickupMeals': pickupMeals,
    };
  }

  static List<UpdatePickupDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UpdatePickupDto>()
        : json
        .map((value) => new UpdatePickupDto.fromJson(value))
        .toList();
  }

  static Map<String, UpdatePickupDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdatePickupDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new UpdatePickupDto.fromJson(value));
    }
    return map;
  }
}
