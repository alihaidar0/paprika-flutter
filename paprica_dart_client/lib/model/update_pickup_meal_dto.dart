part of swagger.api;

class UpdatePickupMealDto {
  int mealId = null;

  int quantity = null;

  String notes = null;

  UpdatePickupMealDto();

  @override
  String toString() {
    return 'UpdatePickupMealDto[mealId=$mealId, quantity=$quantity, notes=$notes,]';
  }

  UpdatePickupMealDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    mealId = json['mealId'];
    quantity = json['quantity'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    return {
      'mealId': mealId,
      'quantity': quantity,
      'notes': notes,
    };
  }

  static List<UpdatePickupMealDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UpdatePickupMealDto>()
        : json.map((value) => new UpdatePickupMealDto.fromJson(value)).toList();
  }

  static Map<String, UpdatePickupMealDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdatePickupMealDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new UpdatePickupMealDto.fromJson(value));
    }
    return map;
  }
}
