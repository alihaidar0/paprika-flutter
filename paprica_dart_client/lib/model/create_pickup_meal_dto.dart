part of swagger.api;

class CreatePickupMealDto {
  int mealId = null;

  int quantity = null;

  String notes = null;


  CreatePickupMealDto();

  @override
  String toString() {
    return 'CreatePickupMealDto[mealId=$mealId, quantity=$quantity, notes=$notes]';
  }

  CreatePickupMealDto.fromJson(Map<String, dynamic> json) {
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

  static List<CreatePickupMealDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CreatePickupMealDto>()
        : json.map((value) => new CreatePickupMealDto.fromJson(value)).toList();
  }

  static Map<String, CreatePickupMealDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CreatePickupMealDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new CreatePickupMealDto.fromJson(value));
    }
    return map;
  }
}
