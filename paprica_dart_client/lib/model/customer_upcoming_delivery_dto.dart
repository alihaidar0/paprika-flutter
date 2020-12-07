part of swagger.api;

class CustomerUpcomingDeliveryDto {
  String restaurantCoverImage = null;

  double restaurantLongitude = null;

  double restaurantLatitude = null;

  double customerLongitude = null;

  double customerLatitude = null;

  String customerAddress = null;

  String restaurantPhoneNumber = null;

  DateTime estimationTime = null;

  double price = null;

  String response = null;

  List<CustomerUpcomingDeliveryMealDto> deliveryMeals = [];

  int id = null;

  int restaurantId = null;

  int status = null;

  String restaurantImage = null;

  String restaurantName = null;

  UpdateDeliveryRequestDto updateRequest = null;

  CustomerUpcomingDeliveryDto();

  @override
  String toString() {
    return 'CustomerUpcomingDeliveryDto[restaurantCoverImage=$restaurantCoverImage, restaurantLongitude=$restaurantLongitude, restaurantLatitude=$restaurantLatitude, customerLongitude=$restaurantLongitude, customerLatitude=$restaurantLatitude, customerAddres$customerAddress, restaurantPhoneNumber=$restaurantPhoneNumber, estimationTime=$estimationTime, price=$price, response=$response, deliveryMeals=$deliveryMeals, id=$id, restaurantId=$restaurantId,  status=$status,  restaurantImage=$restaurantImage, restaurantName=$restaurantName, updateRequest=$updateRequest]';
  }

  CustomerUpcomingDeliveryDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    restaurantCoverImage = json['restaurantCoverImage'];
    restaurantLongitude = json['restaurantLongitude'];
    restaurantLatitude = json['restaurantLatitude'];
    customerLongitude = json['customerLongitude'];
    customerLatitude = json['customerLatitude'];
    customerAddress = json['customerAddress'];
    restaurantPhoneNumber = json['restaurantPhoneNumber'];
    estimationTime =
    json['estimationTime'] == null ? null : DateTime.parse(json['estimationTime'].toString());
    price = json['price'];
    response = json['response'];
    deliveryMeals = CustomerUpcomingDeliveryMealDto.listFromJson(json['deliveryMeals']);
    id = json['id'];
    restaurantId = json['restaurantId'];
    status = json['status'];
    restaurantImage = json['restaurantImage'];
    restaurantName = json['restaurantName'];
    updateRequest = json['updateRequest'] == null
        ? null
        : UpdateDeliveryRequestDto.fromJson(json['updateRequest']);
  }

  Map<String, dynamic> toJson() {
    return {
      'restaurantCoverImage': restaurantCoverImage,
      'restaurantLongitude': restaurantLongitude,
      'restaurantLatitude': restaurantLatitude,
      'customerLongitude': customerLongitude,
      'customerLatitude': customerLatitude,
      'customerAddress' : customerAddress,
      'restaurantPhoneNumber': restaurantPhoneNumber,
      'estimationTime': estimationTime == null ? '' : estimationTime.toUtc().toIso8601String(),
      'price': price,
      'response': response,
      'deliveryMeals': deliveryMeals,
      'id': id,
      'restaurantId': restaurantId,
      'status': status,
      'restaurantImage': restaurantImage,
      'restaurantName': restaurantName,
      'updateRequest': updateRequest
    };
  }

  static List<CustomerUpcomingDeliveryDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CustomerUpcomingDeliveryDto>()
        : json
        .map((value) => new CustomerUpcomingDeliveryDto.fromJson(value))
        .toList();
  }

  static Map<String, CustomerUpcomingDeliveryDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerUpcomingDeliveryDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new CustomerUpcomingDeliveryDto.fromJson(value));
    }
    return map;
  }
}
