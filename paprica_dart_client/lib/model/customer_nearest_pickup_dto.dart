part of swagger.api;

class CustomerNearestPickupDto {
  int id = null;

  int restaurantId = null;

  DateTime date = null;

  int status = null;

  String restaurantImage = null;

  String restaurantName = null;

  double price = null;

  String response = null;

  CustomerNearestPickupDto();

  @override
  String toString() {
    return 'CustomerNearestPickupDto[id=$id, restaurantId=$restaurantId, date=$date, status=$status, restaurantImage=$restaurantImage, restaurantName=$restaurantName, price=$price, response=$response]';
  }

  CustomerNearestPickupDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    restaurantId = json['restaurantId'];
    date = json['date'] == null ? null : DateTime.parse(json['date'].toString());
    status = json['status'];
    restaurantImage = json['restaurantImage'];
    restaurantName = json['restaurantName'];
    price = json['price'];
    response =
    json['response'] == null ? null : json['response'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'date': date == null ? '' : date.toUtc().toIso8601String(),
      'status': status,
      'restaurantImage': restaurantImage,
      'restaurantName': restaurantName,
      'price': price,
      'response': response == null ? null : response,
    };
  }

  static List<CustomerNearestPickupDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CustomerNearestPickupDto>()
        : json
        .map((value) => new CustomerNearestPickupDto.fromJson(value))
        .toList();
  }

  static Map<String, CustomerNearestPickupDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerNearestPickupDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new CustomerNearestPickupDto.fromJson(value));
    }
    return map;
  }
}