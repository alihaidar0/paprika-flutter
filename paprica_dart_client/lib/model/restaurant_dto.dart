part of swagger.api;

class RestaurantDto {
  String name = null;

  double longitude = null;

  double latitude = null;

  String logoImage = null;

  String coverImage = null;

  String phoneNumber = null;

  int rank = null;

  String address = null;

  int regionId = null;

  int status = null;

  int parkingType = null;
  //enum parkingTypeEnum {  1,  };

  String description = null;

  int ambianceType = null;
  //enum ambianceTypeEnum {  1,  };

  String audioTrack = null;

  int musicType = null;

  bool isSmokeFree = null;

  bool isAlcoholFree = null;

  int cuisineTypes = null;
  //enum cuisineTypesEnum {  1,  2,  };

  int amenityTypes = null;
  //enum amenityTypesEnum {  1,  };

  bool hasOutdoor = null;

  bool isFeatured = null;

  bool is24Hour = null;

  bool isOpen = null;

  int id = null;

  RestaurantDto();

  @override
  String toString() {
    return 'RestaurantDto[name=$name, longitude=$longitude, latitude=$latitude, logoImage=$logoImage, coverImage=$coverImage, phoneNumber=$phoneNumber, rank=$rank, address=$address, regionId=$regionId, status=$status, parkingType=$parkingType, description=$description, ambianceType=$ambianceType, audioTrack=$audioTrack, musicType=$musicType, isSmokeFree=$isSmokeFree, isAlcoholFree=$isAlcoholFree, cuisineTypes=$cuisineTypes, amenityTypes=$amenityTypes, hasOutdoor=$hasOutdoor, isFeatured=$isFeatured, is24Hour=$is24Hour, isOpen=$isOpen, id=$id, ]';
  }

  RestaurantDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    logoImage = json['logoImage'];
    coverImage = json['coverImage'];
    phoneNumber = json['phoneNumber'];
    rank = json['rank'];
    address = json['address'];
    regionId = json['regionId'];
    status = json['status'];
    parkingType = json['parkingType'];
    description = json['description'];
    ambianceType = json['ambianceType'];
    audioTrack = json['audioTrack'];
    musicType = json['musicType'];
    isSmokeFree = json['isSmokeFree'];
    isAlcoholFree = json['isAlcoholFree'];
    cuisineTypes = json['cuisineTypes'];
    amenityTypes = json['amenityTypes'];
    hasOutdoor = json['hasOutdoor'];
    isFeatured = json['isFeatured'];
    is24Hour = json['is24Hour'];
    isOpen = json['isOpen'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'longitude': longitude,
      'latitude': latitude,
      'logoImage': logoImage,
      'coverImage': coverImage,
      'phoneNumber': phoneNumber,
      'rank': rank,
      'address': address,
      'regionId': regionId,
      'status': status,
      'parkingType': parkingType,
      'description': description,
      'ambianceType': ambianceType,
      'audioTrack': audioTrack,
      'musicType': musicType,
      'isSmokeFree': isSmokeFree,
      'isAlcoholFree': isAlcoholFree,
      'cuisineTypes': cuisineTypes,
      'amenityTypes': amenityTypes,
      'hasOutdoor': hasOutdoor,
      'isFeatured': isFeatured,
      'is24Hour': is24Hour,
      'isOpen': isOpen,
      'id': id
    };
  }

  static List<RestaurantDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<RestaurantDto>()
        : json.map((value) => new RestaurantDto.fromJson(value)).toList();
  }

  static Map<String, RestaurantDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RestaurantDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new RestaurantDto.fromJson(value));
    }
    return map;
  }
}
