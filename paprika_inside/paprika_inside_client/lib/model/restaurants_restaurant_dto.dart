part of swagger_inside.api;

class RestaurantsRestaurantDto {
  String id = null;

  String name = null;

  String description = null;

  String welcomeMessage = null;

  String logoImage = null;

  String coverImage = null;

  TypesRestaurantStatus status = null;

  RestaurantsRestaurantDto();

  @override
  String toString() {
    return 'RestaurantsRestaurantDto[id=$id, name=$name, description=$description, welcomeMessage=$welcomeMessage, logoImage=$logoImage, coverImage=$coverImage, status=$status, ]';
  }

  RestaurantsRestaurantDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    description = json['description'];
    welcomeMessage = json['welcomeMessage'];
    logoImage = json['logoImage'];
    coverImage = json['coverImage'];
    status = new TypesRestaurantStatus.fromJson(json['status']);
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

  static List<RestaurantsRestaurantDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<RestaurantsRestaurantDto>()
        : json
            .map((value) => new RestaurantsRestaurantDto.fromJson(value))
            .toList();
  }

  static Map<String, RestaurantsRestaurantDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RestaurantsRestaurantDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new RestaurantsRestaurantDto.fromJson(value));
    }
    return map;
  }
}
