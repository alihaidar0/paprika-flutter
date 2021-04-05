part of swagger_inside.api;

class CustomerTablesCreateOrderMealDto {
  String mealId = null;

  int mealVariantId = null;

  int quantity = null;

  String notes = null;

  CustomerTablesCreateOrderMealDto();

  @override
  String toString() {
    return 'CustomerTablesCreateOrderMealDto[mealId=$mealId, mealVariantId=$mealVariantId, quantity=$quantity, notes=$notes, ]';
  }

  CustomerTablesCreateOrderMealDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    mealId = json['mealId'];
    mealVariantId = json['mealVariantId'];
    quantity = json['quantity'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    return {
      'mealId': mealId,
      'mealVariantId': mealVariantId,
      'quantity': quantity,
      'notes': notes
    };
  }

  static List<CustomerTablesCreateOrderMealDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<CustomerTablesCreateOrderMealDto>()
        : json
            .map(
                (value) => new CustomerTablesCreateOrderMealDto.fromJson(value))
            .toList();
  }

  static Map<String, CustomerTablesCreateOrderMealDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerTablesCreateOrderMealDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CustomerTablesCreateOrderMealDto.fromJson(value));
    }
    return map;
  }
}
