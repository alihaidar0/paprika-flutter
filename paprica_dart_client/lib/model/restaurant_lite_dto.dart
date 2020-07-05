part of swagger.api;

class RestaurantLiteDto {
  
  String name = null;
  

  String logoImage = null;
  

  double restaurantRate = null;
  

  bool isOpen = null;
  

  int id = null;
  
  RestaurantLiteDto();

  @override
  String toString() {
    return 'RestaurantLiteDto[name=$name, logoImage=$logoImage, restaurantRate=$restaurantRate, isOpen=$isOpen, id=$id, ]';
  }

  RestaurantLiteDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name =
        json['name']
    ;
    logoImage =
        json['logoImage']
    ;
    restaurantRate =
        json['restaurantRate']
    ;
    isOpen =
        json['isOpen']
    ;
    id =
        json['id']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'logoImage': logoImage,
      'restaurantRate': restaurantRate,
      'isOpen': isOpen,
      'id': id
     };
  }

  static List<RestaurantLiteDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<RestaurantLiteDto>() : json.map((value) => new RestaurantLiteDto.fromJson(value)).toList();
  }

  static Map<String, RestaurantLiteDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RestaurantLiteDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new RestaurantLiteDto.fromJson(value));
    }
    return map;
  }
}

