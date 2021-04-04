part of swagger.api;

class SoftUpPaprikaInsideCustomerTablesCreateOrderMealDto {
  String mealId = null;

  int mealVariantId = null;

  int quantity = null;

  String notes = null;

  SoftUpPaprikaInsideCustomerTablesCreateOrderMealDto();

  @override
  String toString() {
    return 'SoftUpPaprikaInsideCustomerTablesCreateOrderMealDto[mealId=$mealId, mealVariantId=$mealVariantId, quantity=$quantity, notes=$notes, ]';
  }

  SoftUpPaprikaInsideCustomerTablesCreateOrderMealDto.fromJson(
      Map<String, dynamic> json) {
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

  static List<SoftUpPaprikaInsideCustomerTablesCreateOrderMealDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<SoftUpPaprikaInsideCustomerTablesCreateOrderMealDto>()
        : json
            .map((value) =>
                new SoftUpPaprikaInsideCustomerTablesCreateOrderMealDto
                    .fromJson(value))
            .toList();
  }

  static Map<String, SoftUpPaprikaInsideCustomerTablesCreateOrderMealDto>
      mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map =
        new Map<String, SoftUpPaprikaInsideCustomerTablesCreateOrderMealDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] =
          new SoftUpPaprikaInsideCustomerTablesCreateOrderMealDto.fromJson(
              value));
    }
    return map;
  }
}
