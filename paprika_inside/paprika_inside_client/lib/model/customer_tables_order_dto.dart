part of swagger_inside.api;

class CustomerTablesOrderDto {
  String id = null;

  String customerTableId = null;

  TypesOrderStatus status = null;

  double estimationTime = null;

  double totalPrice = null;

  List<CustomerTablesOrderMealDto> orderMeals = [];

  CustomerTablesOrderDto();

  @override
  String toString() {
    return 'CustomerTablesOrderDto[id=$id, customerTableId=$customerTableId, status=$status, estimationTime=$estimationTime, totalPrice=$totalPrice, orderMeals=$orderMeals, ]';
  }

  CustomerTablesOrderDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    customerTableId = json['customerTableId'];
    status = new TypesOrderStatus.fromJson(json['status']);
    estimationTime = json['estimationTime'] == null
        ? null
        : json['estimationTime'].toDouble();
    totalPrice =
        json['totalPrice'] == null ? null : json['totalPrice'].toDouble();
    orderMeals = CustomerTablesOrderMealDto.listFromJson(json['orderMeals']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerTableId': customerTableId,
      'status': status,
      'estimationTime': estimationTime,
      'totalPrice': totalPrice,
      'orderMeals': orderMeals
    };
  }

  static List<CustomerTablesOrderDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CustomerTablesOrderDto>()
        : json
            .map((value) => new CustomerTablesOrderDto.fromJson(value))
            .toList();
  }

  static Map<String, CustomerTablesOrderDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerTablesOrderDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CustomerTablesOrderDto.fromJson(value));
    }
    return map;
  }
}
