part of swagger.api;

class UpdateRestaurantProfileDto {
  String name = null;

  String logoImage = null;

  String coverImage = null;

  String phoneNumber = null;

  int parkingTypes = null;
  //enum parkingTypesEnum {  1,  };

  String description = null;

  int ambianceTypes = null;
  //enum ambianceTypesEnum {  1,  };

  int musicTypes = null;
  //enum musicTypesEnum {  1,  };

  bool isSmokeFree = null;

  bool isAlcoholFree = null;

  int cuisineTypes = null;
  //enum cuisineTypesEnum {  1,  2,  };

  int amenityTypes = null;
  //enum amenityTypesEnum {  1,  };

  bool hasOutdoor = null;

  bool is24Hour = null;

  UpdateRestaurantProfileDto();

  @override
  String toString() {
    return 'UpdateRestaurantProfileDto[name=$name, logoImage=$logoImage, coverImage=$coverImage, phoneNumber=$phoneNumber, parkingTypes=$parkingTypes, description=$description, ambianceTypes=$ambianceTypes, musicTypes=$musicTypes, isSmokeFree=$isSmokeFree, isAlcoholFree=$isAlcoholFree, cuisineTypes=$cuisineTypes, amenityTypes=$amenityTypes, hasOutdoor=$hasOutdoor, is24Hour=$is24Hour, ]';
  }

  UpdateRestaurantProfileDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    logoImage = json['logoImage'];
    coverImage = json['coverImage'];
    phoneNumber = json['phoneNumber'];
    parkingTypes = json['parkingTypes'];
    description = json['description'];
    ambianceTypes = json['ambianceTypes'];
    musicTypes = json['musicTypes'];
    isSmokeFree = json['isSmokeFree'];
    isAlcoholFree = json['isAlcoholFree'];
    cuisineTypes = json['cuisineTypes'];
    amenityTypes = json['amenityTypes'];
    hasOutdoor = json['hasOutdoor'];
    is24Hour = json['is24Hour'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'logoImage': logoImage,
      'coverImage': coverImage,
      'phoneNumber': phoneNumber,
      'parkingTypes': parkingTypes,
      'description': description,
      'ambianceTypes': ambianceTypes,
      'musicTypes': musicTypes,
      'isSmokeFree': isSmokeFree,
      'isAlcoholFree': isAlcoholFree,
      'cuisineTypes': cuisineTypes,
      'amenityTypes': amenityTypes,
      'hasOutdoor': hasOutdoor,
      'is24Hour': is24Hour
    };
  }

  static List<UpdateRestaurantProfileDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UpdateRestaurantProfileDto>()
        : json
            .map((value) => new UpdateRestaurantProfileDto.fromJson(value))
            .toList();
  }

  static Map<String, UpdateRestaurantProfileDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdateRestaurantProfileDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UpdateRestaurantProfileDto.fromJson(value));
    }
    return map;
  }
}
