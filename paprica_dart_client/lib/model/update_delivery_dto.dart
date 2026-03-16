part of swagger.api;

class UpdateDeliveryDto {
  int id = null;

  double longitude = null;

  double latitude = null;

  String address = null;

  int regionId = null;

  List<UpdateDeliveryMealDto> deliveryMeals = [];

  UpdateDeliveryDto();

  @override
  String toString() {
    return 'CreatePickupDto[id=$id, longitude=$longitude, latitude=$latitude, address=$address, regionId=$regionId, deliveryMeals=$deliveryMeals]';
  }

  UpdateDeliveryDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    address = json['address'];
    regionId = json['regionId'];
    deliveryMeals = UpdateDeliveryMealDto.listFromJson(json['deliveryMeals']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'longitude': longitude,
      'latitude': latitude,
      'address': address,
      'regionId': regionId,
      'deliveryMeals': deliveryMeals,
    };
  }

  static List<UpdateDeliveryDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UpdateDeliveryDto>()
        : json
        .map((value) => new UpdateDeliveryDto.fromJson(value))
        .toList();
  }

  static Map<String, UpdateDeliveryDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdateDeliveryDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new UpdateDeliveryDto.fromJson(value));
    }
    return map;
  }
}
