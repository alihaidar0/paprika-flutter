part of swagger.api;

class CustomerUpcomingDeliveryMealDto {
  int mealId = null;

  String mealName = null;

  double mealPrice = null;

  int quantity = null;

  String notes = null;

  int id = null;

  CustomerUpcomingDeliveryMealDto();

  @override
  String toString() {
    return 'CustomerUpcomingDeliveryMealDto[mealId=$mealId, mealName=$mealName, mealPrice=$mealPrice, quantity=$quantity, notes=$notes, id=$id, ]';
  }

  CustomerUpcomingDeliveryMealDto.fromJson(Map<String, dynamic> json) {
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

  static List<CustomerUpcomingDeliveryMealDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CustomerUpcomingDeliveryMealDto>()
        : json.map((value) => new CustomerUpcomingDeliveryMealDto.fromJson(value)).toList();
  }

  static Map<String, CustomerUpcomingDeliveryMealDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerUpcomingDeliveryMealDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new CustomerUpcomingDeliveryMealDto.fromJson(value));
    }
    return map;
  }
}
