part of swagger.api;

class CreateDeliveryMealDto {
  int mealId = null;

  int quantity = null;

  String notes = null;


  CreateDeliveryMealDto();

  @override
  String toString() {
    return 'CreateDeliveryMealDto[mealId=$mealId, quantity=$quantity, notes=$notes]';
  }

  CreateDeliveryMealDto.fromJson(Map<String, dynamic> json) {
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

  static List<CreateDeliveryMealDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CreateDeliveryMealDto>()
        : json.map((value) => new CreateDeliveryMealDto.fromJson(value)).toList();
  }

  static Map<String, CreateDeliveryMealDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CreateDeliveryMealDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new CreateDeliveryMealDto.fromJson(value));
    }
    return map;
  }
}
