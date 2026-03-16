part of swagger.api;

class CreateDeliveryDto {
  int restaurantId = null;

  double longitude = null;

  double latitude = null;

  String address = null;

  int regionId = null;

  List<CreateDeliveryMealDto> deliveryMeals = [];

  CreateDeliveryDto();

  @override
  String toString() {
    return 'CreateDeliveryDto[restaurantId=$restaurantId, longitude=$longitude, latitude=$latitude, address=$address, regionId=$regionId, deliveryMeals=$deliveryMeals]';
  }

  CreateDeliveryDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    restaurantId = json['restaurantId'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    address = json['address'];
    regionId = json['regionId'];
    deliveryMeals = CreateDeliveryMealDto.listFromJson(json['deliveryMeals']);
  }

  Map<String, dynamic> toJson() {
    return {
      'restaurantId': restaurantId,
      'longitude': longitude,
      'latitude': latitude,
      'address': address,
      'regionId': regionId,
      'deliveryMeals': deliveryMeals,
    };
  }

  static List<CreateDeliveryDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CreateDeliveryDto>()
        : json
        .map((value) => new CreateDeliveryDto.fromJson(value))
        .toList();
  }

  static Map<String, CreateDeliveryDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CreateDeliveryDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new CreateDeliveryDto.fromJson(value));
    }
    return map;
  }
}
