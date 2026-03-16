part of swagger.api;

class TypesDto {
  List<EnumValue> musicTypes = [];

  List<EnumValue> cuisineTypes = [];

  List<EnumValue> amenityTypes = [];

  List<EnumValue> ambianceTypes = [];

  List<EnumValue> parkingTypes = [];

  List<EnumValue> noiseLevels = [];

  List<EnumValue> restaurantTypes = [];

  TypesDto();

  @override
  String toString() {
    return 'TypesDto[musicTypes=$musicTypes, cuisineTypes=$cuisineTypes, amenityTypes=$amenityTypes, ambianceTypes=$ambianceTypes, parkingTypes=$parkingTypes, noiseLevels=$noiseLevels, restaurantTypes=$restaurantTypes, ]';
  }

  TypesDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    musicTypes = EnumValue.listFromJson(json['musicTypes']);
    cuisineTypes = EnumValue.listFromJson(json['cuisineTypes']);
    amenityTypes = EnumValue.listFromJson(json['amenityTypes']);
    ambianceTypes = EnumValue.listFromJson(json['ambianceTypes']);
    parkingTypes = EnumValue.listFromJson(json['parkingTypes']);
    noiseLevels = EnumValue.listFromJson(json['noiseLevels']);
    restaurantTypes = EnumValue.listFromJson(json['restaurantTypes']);
  }

  Map<String, dynamic> toJson() {
    return {
      'musicTypes': musicTypes,
      'cuisineTypes': cuisineTypes,
      'amenityTypes': amenityTypes,
      'ambianceTypes': ambianceTypes,
      'parkingTypes': parkingTypes,
      'noiseLevels': noiseLevels,
      'restaurantTypes': restaurantTypes
    };
  }

  static List<TypesDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<TypesDto>()
        : json.map((value) => new TypesDto.fromJson(value)).toList();
  }

  static Map<String, TypesDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, TypesDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new TypesDto.fromJson(value));
    }
    return map;
  }
}
