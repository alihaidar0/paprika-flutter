part of swagger.api;

class SoftUpPaprikaInsideRestaurantsRestaurantDto {
  String id = null;

  String name = null;

  String description = null;

  String welcomeMessage = null;

  String logoImage = null;

  String coverImage = null;

  SoftUpPaprikaInsideTypesRestaurantStatus status = null;

  SoftUpPaprikaInsideRestaurantsRestaurantDto();

  @override
  String toString() {
    return 'SoftUpPaprikaInsideRestaurantsRestaurantDto[id=$id, name=$name, description=$description, welcomeMessage=$welcomeMessage, logoImage=$logoImage, coverImage=$coverImage, status=$status, ]';
  }

  SoftUpPaprikaInsideRestaurantsRestaurantDto.fromJson(
      Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    description = json['description'];
    welcomeMessage = json['welcomeMessage'];
    logoImage = json['logoImage'];
    coverImage = json['coverImage'];
    status =
        new SoftUpPaprikaInsideTypesRestaurantStatus.fromJson(json['status']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'welcomeMessage': welcomeMessage,
      'logoImage': logoImage,
      'coverImage': coverImage,
      'status': status
    };
  }

  static List<SoftUpPaprikaInsideRestaurantsRestaurantDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<SoftUpPaprikaInsideRestaurantsRestaurantDto>()
        : json
            .map((value) =>
                new SoftUpPaprikaInsideRestaurantsRestaurantDto.fromJson(value))
            .toList();
  }

  static Map<String, SoftUpPaprikaInsideRestaurantsRestaurantDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SoftUpPaprikaInsideRestaurantsRestaurantDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] =
          new SoftUpPaprikaInsideRestaurantsRestaurantDto.fromJson(value));
    }
    return map;
  }
}
