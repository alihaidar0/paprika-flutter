part of swagger.api;

class UpdateDeliveryMealRequestDto {
  int mealId = null;

  String mealName = null;

  double mealPrice = null;

  int quantity = null;

  String notes = null;

  UpdateDeliveryMealRequestDto();

  @override
  String toString() {
    return 'UpdateDeliveryMealRequestDto[mealId=$mealId, mealName=$mealName, mealPrice=$mealPrice, quantity=$quantity, notes=$notes]';
  }

  UpdateDeliveryMealRequestDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    mealId = json['mealId'];
    mealName = json['mealName'];
    mealPrice = json['mealPrice'];
    quantity = json['quantity'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    return {
      'mealId': mealId,
      'mealName': mealName,
      'mealPrice': mealPrice,
      'quantity': quantity,
      'notes': notes,
    };
  }

  static List<UpdateDeliveryMealRequestDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UpdateDeliveryMealRequestDto>()
        : json
        .map((value) => new UpdateDeliveryMealRequestDto.fromJson(value))
        .toList();
  }

  static Map<String, UpdateDeliveryMealRequestDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdateDeliveryMealRequestDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new UpdateDeliveryMealRequestDto.fromJson(value));
    }
    return map;
  }
}
