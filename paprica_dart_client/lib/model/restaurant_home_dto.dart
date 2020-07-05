part of swagger.api;

class RestaurantHomeDto {
  double restaurantRate = null;

  double foodRate = null;

  double serviceRate = null;

  double shishaRate = null;

  int noiseLevel = null;

  //enum noiseLevelEnum {  1,  2,  3,  };

  double ambianceRate = null;

  bool isFavorite = null;

  RestaurantEventDto event = null;

  List<OpeningTimeDto> openingTimes = [];

  List<GalleryItemDto> galleryItems = [];

  RestaurantRatersDto restaurantRaters = null;

  RestaurantSettingsDto settings = null;

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

  int parkingTypes = null;

  //enum parkingTypeEnum {  1,  };

  String description = null;

  int ambianceTypes = null;

  //enum ambianceTypeEnum {  1,  };

  String audioTrack = null;

  int musicTypes = null;

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

  RestaurantHomeDto();

  @override
  String toString() {
    return 'RestaurantHomeDto[restaurantRate=$restaurantRate, foodRate=$foodRate, serviceRate=$serviceRate, shishaRate=$shishaRate, noiseLevel=$noiseLevel, ambianceRate=$ambianceRate, isFavorite=$isFavorite, event=$event, openingTimes=$openingTimes, galleryItems=$galleryItems, restaurantRaters=$restaurantRaters, settings=$settings, name=$name, longitude=$longitude, latitude=$latitude, logoImage=$logoImage, coverImage=$coverImage, phoneNumber=$phoneNumber, rank=$rank, address=$address, regionId=$regionId, status=$status, parkingTypes=$parkingTypes, description=$description, ambianceTypes=$ambianceTypes, audioTrack=$audioTrack, musicTypes=$musicTypes, isSmokeFree=$isSmokeFree, isAlcoholFree=$isAlcoholFree, cuisineTypes=$cuisineTypes, amenityTypes=$amenityTypes, hasOutdoor=$hasOutdoor, isFeatured=$isFeatured, is24Hour=$is24Hour, isOpen=$isOpen, id=$id, ]';
  }

  RestaurantHomeDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    restaurantRate = json['restaurantRate'];
    foodRate = json['foodRate'];
    serviceRate = json['serviceRate'];
    shishaRate = json['shishaRate'];
    noiseLevel = json['noiseLevel'];
    ambianceRate = json['ambianceRate'];
    isFavorite = json['isFavorite'];
    event = json['event'] == null ? null : new RestaurantEventDto.fromJson(json['event']);
    openingTimes = OpeningTimeDto.listFromJson(json['openingTimes']);
    galleryItems = GalleryItemDto.listFromJson(json['galleryItems']);
    restaurantRaters = new RestaurantRatersDto.fromJson(json['restaurantRaters']);
    settings = new RestaurantSettingsDto.fromJson(json['settings']);
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
    parkingTypes = json['parkingTypes'];
    description = json['description'];
    ambianceTypes = json['ambianceTypes'];
    audioTrack = json['audioTrack'];
    musicTypes = json['musicTypes'];
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
      'restaurantRate': restaurantRate,
      'foodRate': foodRate,
      'serviceRate': serviceRate,
      'shishaRate': shishaRate,
      'noiseLevel': noiseLevel,
      'ambianceRate': ambianceRate,
      'isFavorite': isFavorite,
      'event': event,
      'openingTimes': openingTimes,
      'galleryItems': galleryItems,
      'restaurantRaters': restaurantRaters,
      'settings': settings,
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
      'parkingTypes': parkingTypes,
      'description': description,
      'ambianceTypes': ambianceTypes,
      'audioTrack': audioTrack,
      'musicTypes': musicTypes,
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

  static List<RestaurantHomeDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<RestaurantHomeDto>() : json.map((value) => new RestaurantHomeDto.fromJson(value)).toList();
  }

  static Map<String, RestaurantHomeDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RestaurantHomeDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new RestaurantHomeDto.fromJson(value));
    }
    return map;
  }
}
