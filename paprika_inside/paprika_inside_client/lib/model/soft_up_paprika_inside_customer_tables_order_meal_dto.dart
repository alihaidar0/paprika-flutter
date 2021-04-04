part of swagger.api;

class SoftUpPaprikaInsideCustomerTablesOrderMealDto {
  int id = null;

  String mealId = null;

  String name = null;

  double price = null;

  String mealVariant = null;

  int mealVariantId = null;

  int quantity = null;

  String notes = null;

  DateTime estimationTime = null;

  SoftUpPaprikaInsideCustomerTablesOrderMealDto();

  @override
  String toString() {
    return 'SoftUpPaprikaInsideCustomerTablesOrderMealDto[id=$id, mealId=$mealId, name=$name, price=$price, mealVariant=$mealVariant, mealVariantId=$mealVariantId, quantity=$quantity, notes=$notes, estimationTime=$estimationTime, ]';
  }

  SoftUpPaprikaInsideCustomerTablesOrderMealDto.fromJson(
      Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    mealId = json['mealId'];
    name = json['name'];
    price = json['price'] == null ? null : json['price'].toDouble();
    mealVariant = json['mealVariant'];
    mealVariantId = json['mealVariantId'];
    quantity = json['quantity'];
    notes = json['notes'];
    estimationTime = json['estimationTime'] == null
        ? null
        : DateTime.parse(json['estimationTime']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mealId': mealId,
      'name': name,
      'price': price,
      'mealVariant': mealVariant,
      'mealVariantId': mealVariantId,
      'quantity': quantity,
      'notes': notes,
      'estimationTime':
          estimationTime == null ? '' : estimationTime.toUtc().toIso8601String()
    };
  }

  static List<SoftUpPaprikaInsideCustomerTablesOrderMealDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<SoftUpPaprikaInsideCustomerTablesOrderMealDto>()
        : json
            .map((value) =>
                new SoftUpPaprikaInsideCustomerTablesOrderMealDto.fromJson(
                    value))
            .toList();
  }

  static Map<String, SoftUpPaprikaInsideCustomerTablesOrderMealDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SoftUpPaprikaInsideCustomerTablesOrderMealDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] =
          new SoftUpPaprikaInsideCustomerTablesOrderMealDto.fromJson(value));
    }
    return map;
  }
}
