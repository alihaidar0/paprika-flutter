part of swagger.api;

class RestaurantSummaryDto {
  String name = null;

  int restaurantTypes = null;

  String address = null;

  String logoImage = null;

  double restaurantRate = null;

  double foodRate = null;

  double serviceRate = null;

  double shishaRate = null;

  double ambianceRate = null;

  int noiseLevel = null;

  double longitude = null;

  double latitude = null;

  CityDto city = null;

  CountryDto country = null;

  RegionDto region = null;

  bool isOpen = null;

  String phoneNumber = null;

  String tel = null;

  bool hasShisha = null;

  int id = null;

  RestaurantSummaryDto();

  @override
  String toString() {
    return 'RestaurantSummaryDto[name=$name, restaurantTypes=$restaurantTypes, phoneNumber=$phoneNumber, tel=$tel, address=$address, logoImage=$logoImage, restaurantRate=$restaurantRate, foodRate=$foodRate, serviceRate=$serviceRate, shishaRate=$shishaRate, ambianceRate=$ambianceRate, noiseLevel=$noiseLevel, longitude=$longitude, latitude=$latitude, city=$city, country=$country, region=$region, isOpen=$isOpen, hasShisha=$hasShisha, id=$id, ]';
  }

  RestaurantSummaryDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    restaurantTypes = json['restaurantTypes'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    logoImage = json['logoImage'];
    restaurantRate = json['restaurantRate'];
    foodRate = json['foodRate'];
    serviceRate = json['serviceRate'];
    shishaRate = json['shishaRate'];
    ambianceRate = json['ambianceRate'];
    noiseLevel = json['noiseLevel'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    city = new CityDto.fromJson(json['city']);
    country = new CountryDto.fromJson(json['country']);
    region = new RegionDto.fromJson(json['region']);
    isOpen = json['isOpen'];
    hasShisha = json['hasShisha'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'restaurantTypes': restaurantTypes,
      'phoneNumber': phoneNumber,
      'address': address,
      'logoImage': logoImage,
      'restaurantRate': restaurantRate,
      'foodRate': foodRate,
      'serviceRate': serviceRate,
      'shishaRate': shishaRate,
      'ambianceRate': ambianceRate,
      'noiseLevel': noiseLevel,
      'longitude': longitude,
      'latitude': latitude,
      'city': city,
      'country': country,
      'region': region,
      'isOpen': isOpen,
      'hasShisha': hasShisha,
      'id': id,
    };
  }

  static List<RestaurantSummaryDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<RestaurantSummaryDto>()
        : json
            .map((value) => new RestaurantSummaryDto.fromJson(value))
            .toList();
  }

  static Map<String, RestaurantSummaryDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RestaurantSummaryDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new RestaurantSummaryDto.fromJson(value));
    }
    return map;
  }
}
