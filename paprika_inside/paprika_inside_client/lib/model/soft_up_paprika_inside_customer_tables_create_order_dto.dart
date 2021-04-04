part of swagger_inside.api;

class SoftUpPaprikaInsideCustomerTablesCreateOrderDto {
  String customerTableId = null;

  List<SoftUpPaprikaInsideCustomerTablesCreateOrderMealDto> orderMeals = [];

  SoftUpPaprikaInsideCustomerTablesCreateOrderDto();

  @override
  String toString() {
    return 'SoftUpPaprikaInsideCustomerTablesCreateOrderDto[customerTableId=$customerTableId, orderMeals=$orderMeals, ]';
  }

  SoftUpPaprikaInsideCustomerTablesCreateOrderDto.fromJson(
      Map<String, dynamic> json) {
    if (json == null) return;
    customerTableId = json['customerTableId'];
    orderMeals =
        SoftUpPaprikaInsideCustomerTablesCreateOrderMealDto.listFromJson(
            json['orderMeals']);
  }

  Map<String, dynamic> toJson() {
    return {'customerTableId': customerTableId, 'orderMeals': orderMeals};
  }

  static List<SoftUpPaprikaInsideCustomerTablesCreateOrderDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<SoftUpPaprikaInsideCustomerTablesCreateOrderDto>()
        : json
            .map((value) =>
                new SoftUpPaprikaInsideCustomerTablesCreateOrderDto.fromJson(
                    value))
            .toList();
  }

  static Map<String, SoftUpPaprikaInsideCustomerTablesCreateOrderDto>
      mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map =
        new Map<String, SoftUpPaprikaInsideCustomerTablesCreateOrderDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] =
          new SoftUpPaprikaInsideCustomerTablesCreateOrderDto.fromJson(value));
    }
    return map;
  }
}
