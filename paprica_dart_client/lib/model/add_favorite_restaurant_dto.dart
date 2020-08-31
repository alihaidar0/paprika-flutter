part of swagger.api;

class AddFavoriteRestaurantDto {
  int restaurantId = null;

  AddFavoriteRestaurantDto();

  @override
  String toString() {
    return 'AddFavoriteRestaurantDto[restaurantId=$restaurantId, ]';
  }

  AddFavoriteRestaurantDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    restaurantId = json['restaurantId'];
  }

  Map<String, dynamic> toJson() {
    return {'restaurantId': restaurantId};
  }

  static List<AddFavoriteRestaurantDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<AddFavoriteRestaurantDto>()
        : json
            .map((value) => new AddFavoriteRestaurantDto.fromJson(value))
            .toList();
  }

  static Map<String, AddFavoriteRestaurantDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AddFavoriteRestaurantDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AddFavoriteRestaurantDto.fromJson(value));
    }
    return map;
  }
}
