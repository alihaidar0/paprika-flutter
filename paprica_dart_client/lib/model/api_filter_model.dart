part of swagger.api;

class ApiFilterModel {
  int parkingType;
  int ambianceType;

  int musicType;
  bool isSmokeFree;

  bool isAlcoholFree;
  int cuisineTypes;

  int amenityTypes;
  bool hasOutdoor;

  bool is24Hour;
  int restaurantTypes;

  double longitude;
  double latitude;

  bool isFeatured;
  int skipCount;

  int maxResultCount;

  ApiFilterModel();

  ApiFilterModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    parkingType = json['parkingType'];
    ambianceType = json['ambianceType'];
    musicType = json['musicType'];
    isSmokeFree = json['isSmokeFree'];
    isAlcoholFree = json['isAlcoholFree'];
    cuisineTypes = json['cuisineTypes'];
    amenityTypes = json['amenityTypes'];
    hasOutdoor = json['hasOutdoor'];
    is24Hour = json['is24Hour'];
    restaurantTypes = json['restaurantTypes'];
    longitude = json['longitude']?.toDouble();
    latitude = json['latitude']?.toDouble();
    isFeatured = json['isFeatured'];
    skipCount = json['skipCount'];
    maxResultCount = json['maxResultCount'];
  }

  Map<String, dynamic> toJson() {
    return {
      'parkingType': parkingType,
      'ambianceType': ambianceType,
      'musicType': musicType,
      'isSmokeFree': isSmokeFree,
      'isAlcoholFree': isAlcoholFree,
      'cuisineTypes': cuisineTypes,
      'amenityTypes': amenityTypes,
      'hasOutdoor': hasOutdoor,
      'is24Hour': is24Hour,
      'restaurantTypes': restaurantTypes,
      'longitude': longitude,
      'latitude': latitude,
      'isFeatured': isFeatured,
      'skipCount': skipCount,
      'maxResultCount': maxResultCount,
    };
  }

  static List<ApiFilterModel> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ApiFilterModel>()
        : json.map((value) => new ApiFilterModel.fromJson(value)).toList();
  }

  static Map<String, ApiFilterModel> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ApiFilterModel>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ApiFilterModel.fromJson(value));
    }
    return map;
  }
}
