part of swagger.api;

class UpdateIsFeaturedDto {
  int restaurantId = null;

  bool isFeatured = null;

  UpdateIsFeaturedDto();

  @override
  String toString() {
    return 'UpdateIsFeaturedDto[restaurantId=$restaurantId, isFeatured=$isFeatured, ]';
  }

  UpdateIsFeaturedDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    restaurantId = json['restaurantId'];
    isFeatured = json['isFeatured'];
  }

  Map<String, dynamic> toJson() {
    return {'restaurantId': restaurantId, 'isFeatured': isFeatured};
  }

  static List<UpdateIsFeaturedDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UpdateIsFeaturedDto>()
        : json.map((value) => new UpdateIsFeaturedDto.fromJson(value)).toList();
  }

  static Map<String, UpdateIsFeaturedDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdateIsFeaturedDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UpdateIsFeaturedDto.fromJson(value));
    }
    return map;
  }
}
