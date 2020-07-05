part of swagger.api;

class CreateRestaurantDto {
  
  String name = null;
  

  String logoImage = null;
  

  String coverImage = null;
  

  String phoneNumber = null;
  

  double longitude = null;
  

  double latitude = null;
  

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
  //enum musicTypeEnum {  1,  };

  bool isSmokeFree = null;
  

  bool isAlcoholFree = null;
  

  int cuisineTypes = null;
  //enum cuisineTypesEnum {  1,  2,  };

  int amenityTypes = null;
  //enum amenityTypesEnum {  1,  };

  int managerId = null;
  

  bool hasOutdoor = null;
  

  bool isFeatured = null;
  

  bool is24Hour = null;
  
  CreateRestaurantDto();

  @override
  String toString() {
    return 'CreateRestaurantDto[name=$name, logoImage=$logoImage, coverImage=$coverImage, phoneNumber=$phoneNumber, longitude=$longitude, latitude=$latitude, rank=$rank, address=$address, regionId=$regionId, status=$status, parkingType=$parkingType, description=$description, ambianceType=$ambianceType, audioTrack=$audioTrack, musicType=$musicType, isSmokeFree=$isSmokeFree, isAlcoholFree=$isAlcoholFree, cuisineTypes=$cuisineTypes, amenityTypes=$amenityTypes, managerId=$managerId, hasOutdoor=$hasOutdoor, isFeatured=$isFeatured, is24Hour=$is24Hour, ]';
  }

  CreateRestaurantDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name =
        json['name']
    ;
    logoImage =
        json['logoImage']
    ;
    coverImage =
        json['coverImage']
    ;
    phoneNumber =
        json['phoneNumber']
    ;
    longitude =
        json['longitude']
    ;
    latitude =
        json['latitude']
    ;
    rank =
        json['rank']
    ;
    address =
        json['address']
    ;
    regionId =
        json['regionId']
    ;
    status =
        json['status']
    ;
    parkingType =
        json['parkingType']
    ;
    description =
        json['description']
    ;
    ambianceType =
        json['ambianceType']
    ;
    audioTrack =
        json['audioTrack']
    ;
    musicType =
        json['musicType']
    ;
    isSmokeFree =
        json['isSmokeFree']
    ;
    isAlcoholFree =
        json['isAlcoholFree']
    ;
    cuisineTypes =
        json['cuisineTypes']
    ;
    amenityTypes =
        json['amenityTypes']
    ;
    managerId =
        json['managerId']
    ;
    hasOutdoor =
        json['hasOutdoor']
    ;
    isFeatured =
        json['isFeatured']
    ;
    is24Hour =
        json['is24Hour']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'logoImage': logoImage,
      'coverImage': coverImage,
      'phoneNumber': phoneNumber,
      'longitude': longitude,
      'latitude': latitude,
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
      'managerId': managerId,
      'hasOutdoor': hasOutdoor,
      'isFeatured': isFeatured,
      'is24Hour': is24Hour
     };
  }

  static List<CreateRestaurantDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<CreateRestaurantDto>() : json.map((value) => new CreateRestaurantDto.fromJson(value)).toList();
  }

  static Map<String, CreateRestaurantDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CreateRestaurantDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new CreateRestaurantDto.fromJson(value));
    }
    return map;
  }
}

