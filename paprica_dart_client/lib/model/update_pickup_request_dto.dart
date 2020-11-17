part of swagger.api;

class UpdatePickupRequestDto {
  int pickupId = null;

  DateTime time = null;

  double price = null;

  List<UpdatePickupMealRequestDto> pickupMeals = [];

  UpdatePickupRequestDto();

  @override
  String toString() {
    return 'UpdateReservationRequestDto[pickupId=$pickupId, time=$time, price=$price, pickupMeals=$pickupMeals]';
  }

  UpdatePickupRequestDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    pickupId = json['pickupId'];
    time =
    json['time'] == null ? null : DateTime.parse(json['time'].toString());
    price = json['price'];
    pickupMeals = UpdatePickupMealRequestDto.listFromJson(json['pickupMeals']);
  }

  Map<String, dynamic> toJson() {
    return {
      'pickupId': pickupId,
      'time': time == null ? '' : time.toUtc().toIso8601String(),
      'price': price,
      'pickupMeals': pickupMeals,
    };
  }

  static List<UpdatePickupRequestDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UpdatePickupRequestDto>()
        : json
        .map((value) => new UpdatePickupRequestDto.fromJson(value))
        .toList();
  }

  static Map<String, UpdatePickupRequestDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdatePickupRequestDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new UpdatePickupRequestDto.fromJson(value));
    }
    return map;
  }
}
