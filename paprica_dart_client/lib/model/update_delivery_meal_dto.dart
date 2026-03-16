part of swagger.api;

class UpdateDeliveryMealDto {
  int mealId = null;

  int quantity = null;

  String notes = null;

  UpdateDeliveryMealDto();

  @override
  String toString() {
    return 'UpdateDeliveryMealDto[mealId=$mealId, quantity=$quantity, notes=$notes,]';
  }

  UpdateDeliveryMealDto.fromJson(Map<String, dynamic> json) {
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

  static List<UpdateDeliveryMealDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UpdateDeliveryMealDto>()
        : json.map((value) => new UpdateDeliveryMealDto.fromJson(value)).toList();
  }

  static Map<String, UpdateDeliveryMealDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdateDeliveryMealDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new UpdateDeliveryMealDto.fromJson(value));
    }
    return map;
  }
}
