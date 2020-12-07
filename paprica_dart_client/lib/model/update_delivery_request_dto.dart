part of swagger.api;

class UpdateDeliveryRequestDto {
  int deliveryId = null;

  double Longitude = null;

  double Latitude = null;

  String address = null;

  double price = null;

  List<UpdateDeliveryMealRequestDto> deliveryMeals = [];

  UpdateDeliveryRequestDto();

  @override
  String toString() {
    return 'UpdateDeliveryRequestDto[deliveryId=$deliveryId, Longitude=$Longitude, Latitude=$Latitude, address=$address, price=$price, deliveryMeals=$deliveryMeals]';
  }

  UpdateDeliveryRequestDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    deliveryId = json['deliveryId'];
    Longitude = json['Longitude'];
    Latitude = json['Latitude'];
    address = json['address'];
    price = json['price'];
    deliveryMeals = UpdateDeliveryMealRequestDto.listFromJson(json['deliveryMeals']);
  }

  Map<String, dynamic> toJson() {
    return {
      'deliveryId': deliveryId,
      'Longitude': Longitude,
      'Latitude': Latitude,
      'address': address,
      'price': price,
      'deliveryMeals': deliveryMeals,
    };
  }

  static List<UpdateDeliveryRequestDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UpdateDeliveryRequestDto>()
        : json
        .map((value) => new UpdateDeliveryRequestDto.fromJson(value))
        .toList();
  }

  static Map<String, UpdateDeliveryRequestDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdateDeliveryRequestDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new UpdateDeliveryRequestDto.fromJson(value));
    }
    return map;
  }
}
