part of swagger.api;

class RestaurantEventDto {
  String name = null;

  int restaurantId = null;

  String restaurantName = null;

  String image = null;

  String description = null;

  DateTime time = null;

  int id = null;

  RestaurantEventDto();

  @override
  String toString() {
    return 'RestaurantEventDto[name=$name, restaurantId=$restaurantId, restaurantName=$restaurantName, image=$image, description=$description, time=$time, id=$id, ]';
  }

  RestaurantEventDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    restaurantId = json['restaurantId'];
    restaurantName = json['restaurantName'];
    image = json['image'];
    description = json['description'];
    time =
        json['time'] == null ? null : DateTime.parse(json['time'].toString());
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'image': image,
      'description': description,
      'time': time == null ? '' : time.toUtc().toIso8601String(),
      'id': id
    };
  }

  static List<RestaurantEventDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<RestaurantEventDto>()
        : json.map((value) => new RestaurantEventDto.fromJson(value)).toList();
  }

  static Map<String, RestaurantEventDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RestaurantEventDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new RestaurantEventDto.fromJson(value));
    }
    return map;
  }
}
