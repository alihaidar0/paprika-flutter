part of swagger.api;

class CustomerUpcomingPickupDto {
  String restaurantCoverImage = null;

  double restaurantLongitude = null;

  double restaurantLatitude = null;

  String restaurantPhoneNumber = null;

  double price = null;

  String response = null;

  List<CustomerUpcomingPickupMealDto> pickupMeals = [];

  int id = null;

  int restaurantId = null;

  DateTime date = null;

  int status = null;

  String restaurantImage = null;

  String restaurantName = null;

  UpdatePickupRequestDto updateRequest = null;

  CustomerUpcomingPickupDto();

  @override
  String toString() {
    return 'CustomerUpcomingPickupDto[restaurantCoverImage=$restaurantCoverImage, restaurantLongitude=$restaurantLongitude, restaurantLatitude=$restaurantLatitude, restaurantPhoneNumber=$restaurantPhoneNumber, price=$price, response=$response, pickupMeals=$pickupMeals, id=$id, restaurantId=$restaurantId, date=$date, status=$status,  restaurantImage=$restaurantImage, restaurantName=$restaurantName, updateRequest=$updateRequest]';
  }

  CustomerUpcomingPickupDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    restaurantCoverImage = json['restaurantCoverImage'];
    restaurantLongitude = json['restaurantLongitude'];
    restaurantLatitude = json['restaurantLatitude'];
    restaurantPhoneNumber = json['restaurantPhoneNumber'];
    price = json['price'];
    response = json['response'];
    pickupMeals = CustomerUpcomingPickupMealDto.listFromJson(json['pickupMeals']);
    id = json['id'];
    restaurantId = json['restaurantId'];
    date =
    json['date'] == null ? null : DateTime.parse(json['date'].toString());
    status = json['status'];
    restaurantImage = json['restaurantImage'];
    restaurantName = json['restaurantName'];
    updateRequest = json['updateRequest'] == null
        ? null
        : UpdatePickupRequestDto.fromJson(json['updateRequest']);
  }

  Map<String, dynamic> toJson() {
    return {
      'restaurantCoverImage': restaurantCoverImage,
      'restaurantLongitude': restaurantLongitude,
      'restaurantLatitude': restaurantLatitude,
      'restaurantPhoneNumber': restaurantPhoneNumber,
      'price': price,
      'response': response,
      'pickupMeals': pickupMeals,
      'id': id,
      'restaurantId': restaurantId,
      'date': date == null ? '' : date.toUtc().toIso8601String(),
      'status': status,
      'restaurantImage': restaurantImage,
      'restaurantName': restaurantName,
      'updateRequest': updateRequest
    };
  }

  static List<CustomerUpcomingPickupDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CustomerUpcomingPickupDto>()
        : json
        .map((value) => new CustomerUpcomingPickupDto.fromJson(value))
        .toList();
  }

  static Map<String, CustomerUpcomingPickupDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerUpcomingPickupDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new CustomerUpcomingPickupDto.fromJson(value));
    }
    return map;
  }
}
