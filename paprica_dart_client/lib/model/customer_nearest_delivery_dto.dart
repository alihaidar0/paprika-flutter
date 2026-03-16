part of swagger.api;

class CustomerNearestDeliveryDto {
  int id = null;

  int restaurantId = null;

  int status = null;

  String restaurantImage = null;

  String restaurantName = null;

  DateTime estimationTime = null;

  double price = null;

  String response = null;

  String customerAddress = null;

  CustomerNearestDeliveryDto();

  @override
  String toString() {
    return 'CustomerNearestDeliveryDto[id=$id, restaurantId=$restaurantId, status=$status, restaurantImage=$restaurantImage, restaurantName=$restaurantName, estimationTime=$estimationTime, price=$price, response=$response, customerAddress=$customerAddress]';
  }

  CustomerNearestDeliveryDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    restaurantId = json['restaurantId'];
    status = json['status'];
    restaurantImage = json['restaurantImage'];
    restaurantName = json['restaurantName'];
    estimationTime = json['estimationTime'] == null ? null : DateTime.parse(json['estimationTime'].toString());
    price = json['price'];
    response =
    json['response'] == null ? null : json['response'];
    customerAddress = json['customerAddress'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'status': status,
      'restaurantImage': restaurantImage,
      'restaurantName': restaurantName,
      'estimationTime': estimationTime == null ? '' : estimationTime.toUtc().toIso8601String(),
      'price': price,
      'response': response == null ? null : response,
      'customerAddress': customerAddress,
    };
  }

  static List<CustomerNearestDeliveryDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CustomerNearestDeliveryDto>()
        : json
        .map((value) => new CustomerNearestDeliveryDto.fromJson(value))
        .toList();
  }

  static Map<String, CustomerNearestDeliveryDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerNearestDeliveryDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new CustomerNearestDeliveryDto.fromJson(value));
    }
    return map;
  }
}