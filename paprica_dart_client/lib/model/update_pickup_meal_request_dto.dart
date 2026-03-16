part of swagger.api;

class UpdatePickupMealRequestDto {
  int mealId = null;

  String mealName = null;

  double mealPrice = null;

  int quantity = null;

  String notes = null;

  UpdatePickupMealRequestDto();

  @override
  String toString() {
    return 'UpdatePickupMealRequestDto[mealId=$mealId, mealName=$mealName, mealPrice=$mealPrice, quantity=$quantity, notes=$notes]';
  }

  UpdatePickupMealRequestDto.fromJson(Map<String, dynamic> json) {
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

  static List<UpdatePickupMealRequestDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UpdatePickupMealRequestDto>()
        : json
        .map((value) => new UpdatePickupMealRequestDto.fromJson(value))
        .toList();
  }

  static Map<String, UpdatePickupMealRequestDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdatePickupMealRequestDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new UpdatePickupMealRequestDto.fromJson(value));
    }
    return map;
  }
}
