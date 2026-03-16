part of swagger.api;

class FeaturedAndNearbyRestaurantDto {
  PagedResultDtoRestaurantLiteDto nearbyRestaurants = null;

  PagedResultDtoRestaurantLiteDto featuredRestaurants = null;

  FeaturedAndNearbyRestaurantDto();

  @override
  String toString() {
    return 'FeaturedAndNearbyRestaurantDto[nearbyRestaurants=$nearbyRestaurants, featuredRestaurants=$featuredRestaurants, ]';
  }

  FeaturedAndNearbyRestaurantDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    nearbyRestaurants =
        new PagedResultDtoRestaurantLiteDto.fromJson(json['nearbyRestaurants']);
    featuredRestaurants = new PagedResultDtoRestaurantLiteDto.fromJson(
        json['featuredRestaurants']);
  }

  Map<String, dynamic> toJson() {
    return {
      'nearbyRestaurants': nearbyRestaurants,
      'featuredRestaurants': featuredRestaurants
    };
  }

  static List<FeaturedAndNearbyRestaurantDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<FeaturedAndNearbyRestaurantDto>()
        : json
            .map((value) => new FeaturedAndNearbyRestaurantDto.fromJson(value))
            .toList();
  }

  static Map<String, FeaturedAndNearbyRestaurantDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, FeaturedAndNearbyRestaurantDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new FeaturedAndNearbyRestaurantDto.fromJson(value));
    }
    return map;
  }
}
