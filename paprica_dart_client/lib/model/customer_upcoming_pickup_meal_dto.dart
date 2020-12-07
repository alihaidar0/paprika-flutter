part of swagger.api;

class CustomerUpcomingPickupMealDto {
  int mealId = null;

  String mealName = null;

  double mealPrice = null;

  int quantity = null;

  String notes = null;

  int id = null;

  CustomerUpcomingPickupMealDto();

  @override
  String toString() {
    return 'CustomerUpcomingPickupMealDto[mealId=$mealId, mealName=$mealName, mealPrice=$mealPrice, quantity=$quantity, notes=$notes, id=$id, ]';
  }

  CustomerUpcomingPickupMealDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    mealId = json['mealId'];
    mealName = json['mealName'];
    mealPrice = json['mealPrice'];
    quantity = json['quantity'];
    notes = json['notes'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'mealId': mealId,
      'mealName': mealName,
      'mealPrice': mealPrice,
      'quantity': quantity,
      'notes': notes,
      'id': id
    };
  }

  static List<CustomerUpcomingPickupMealDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CustomerUpcomingPickupMealDto>()
        : json.map((value) => new CustomerUpcomingPickupMealDto.fromJson(value)).toList();
  }

  static Map<String, CustomerUpcomingPickupMealDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerUpcomingPickupMealDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new CustomerUpcomingPickupMealDto.fromJson(value));
    }
    return map;
  }
}
