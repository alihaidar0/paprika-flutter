part of swagger.api;

class SoftUpPaprikaInsideCustomerTablesUpdateOrderDto {
  String id = null;

  List<SoftUpPaprikaInsideCustomerTablesCreateOrderMealDto> orderMeals = [];

  SoftUpPaprikaInsideCustomerTablesUpdateOrderDto();

  @override
  String toString() {
    return 'SoftUpPaprikaInsideCustomerTablesUpdateOrderDto[id=$id, orderMeals=$orderMeals, ]';
  }

  SoftUpPaprikaInsideCustomerTablesUpdateOrderDto.fromJson(
      Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    orderMeals =
        SoftUpPaprikaInsideCustomerTablesCreateOrderMealDto.listFromJson(
            json['orderMeals']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'orderMeals': orderMeals};
  }

  static List<SoftUpPaprikaInsideCustomerTablesUpdateOrderDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<SoftUpPaprikaInsideCustomerTablesUpdateOrderDto>()
        : json
            .map((value) =>
                new SoftUpPaprikaInsideCustomerTablesUpdateOrderDto.fromJson(
                    value))
            .toList();
  }

  static Map<String, SoftUpPaprikaInsideCustomerTablesUpdateOrderDto>
      mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map =
        new Map<String, SoftUpPaprikaInsideCustomerTablesUpdateOrderDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] =
          new SoftUpPaprikaInsideCustomerTablesUpdateOrderDto.fromJson(value));
    }
    return map;
  }
}
