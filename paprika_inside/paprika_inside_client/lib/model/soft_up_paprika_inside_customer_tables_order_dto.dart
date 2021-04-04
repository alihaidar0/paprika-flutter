part of swagger.api;

class SoftUpPaprikaInsideCustomerTablesOrderDto {
  String id = null;

  String customerTableId = null;

  SoftUpPaprikaInsideTypesOrderStatus status = null;

  double estimationTime = null;

  double totalPrice = null;

  List<SoftUpPaprikaInsideCustomerTablesOrderMealDto> orderMeals = [];

  SoftUpPaprikaInsideCustomerTablesOrderDto();

  @override
  String toString() {
    return 'SoftUpPaprikaInsideCustomerTablesOrderDto[id=$id, customerTableId=$customerTableId, status=$status, estimationTime=$estimationTime, totalPrice=$totalPrice, orderMeals=$orderMeals, ]';
  }

  SoftUpPaprikaInsideCustomerTablesOrderDto.fromJson(
      Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    customerTableId = json['customerTableId'];
    status = new SoftUpPaprikaInsideTypesOrderStatus.fromJson(json['status']);
    estimationTime = json['estimationTime'] == null
        ? null
        : json['estimationTime'].toDouble();
    totalPrice =
        json['totalPrice'] == null ? null : json['totalPrice'].toDouble();
    orderMeals = SoftUpPaprikaInsideCustomerTablesOrderMealDto.listFromJson(
        json['orderMeals']);
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

  static List<SoftUpPaprikaInsideCustomerTablesOrderDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<SoftUpPaprikaInsideCustomerTablesOrderDto>()
        : json
            .map((value) =>
                new SoftUpPaprikaInsideCustomerTablesOrderDto.fromJson(value))
            .toList();
  }

  static Map<String, SoftUpPaprikaInsideCustomerTablesOrderDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SoftUpPaprikaInsideCustomerTablesOrderDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] =
          new SoftUpPaprikaInsideCustomerTablesOrderDto.fromJson(value));
    }
    return map;
  }
}
