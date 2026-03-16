part of swagger_inside.api;

class CustomerTablesCreateOrderDto {
  String customerTableId = null;

  List<CustomerTablesCreateOrderMealDto> orderMeals = [];

  CustomerTablesCreateOrderDto();

  @override
  String toString() {
    return 'CustomerTablesCreateOrderDto[customerTableId=$customerTableId, orderMeals=$orderMeals, ]';
  }

  CustomerTablesCreateOrderDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    customerTableId = json['customerTableId'];
    orderMeals =
        CustomerTablesCreateOrderMealDto.listFromJson(json['orderMeals']);
  }

  Map<String, dynamic> toJson() {
    return {'customerTableId': customerTableId, 'orderMeals': orderMeals};
  }

  static List<CustomerTablesCreateOrderDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CustomerTablesCreateOrderDto>()
        : json
            .map((value) => new CustomerTablesCreateOrderDto.fromJson(value))
            .toList();
  }

  static Map<String, CustomerTablesCreateOrderDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerTablesCreateOrderDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CustomerTablesCreateOrderDto.fromJson(value));
    }
    return map;
  }
}
