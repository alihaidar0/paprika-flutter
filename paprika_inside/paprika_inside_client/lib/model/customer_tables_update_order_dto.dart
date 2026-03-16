part of swagger_inside.api;

class CustomerTablesUpdateOrderDto {
  String id = null;

  List<CustomerTablesCreateOrderMealDto> orderMeals = [];

  CustomerTablesUpdateOrderDto();

  @override
  String toString() {
    return 'CustomerTablesUpdateOrderDto[id=$id, orderMeals=$orderMeals, ]';
  }

  CustomerTablesUpdateOrderDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    orderMeals =
        CustomerTablesCreateOrderMealDto.listFromJson(json['orderMeals']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'orderMeals': orderMeals};
  }

  static List<CustomerTablesUpdateOrderDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CustomerTablesUpdateOrderDto>()
        : json
            .map((value) => new CustomerTablesUpdateOrderDto.fromJson(value))
            .toList();
  }

  static Map<String, CustomerTablesUpdateOrderDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerTablesUpdateOrderDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CustomerTablesUpdateOrderDto.fromJson(value));
    }
    return map;
  }
}
