part of swagger.api;

class CreateOrUpdateReviewDto {
  int id = null;

  String comment = null;

  double foodRate = null;

  double serviceRate = null;

  double ambianceRate = null;

  int noiseLevel = null;
  //enum noiseLevelEnum {  1,  2,  3,  };

  double shishaRate = null;

  double restaurantRate = null;

  int restaurantId = null;

  CreateOrUpdateReviewDto();

  @override
  String toString() {
    return 'CreateOrUpdateReviewDto[id=$id, comment=$comment, foodRate=$foodRate, serviceRate=$serviceRate, ambianceRate=$ambianceRate, noiseLevel=$noiseLevel, shishaRate=$shishaRate, restaurantRate=$restaurantRate, restaurantId=$restaurantId, ]';
  }

  CreateOrUpdateReviewDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    comment = json['comment'];
    foodRate = json['foodRate'];
    serviceRate = json['serviceRate'];
    ambianceRate = json['ambianceRate'];
    noiseLevel = json['noiseLevel'];
    shishaRate = json['shishaRate'];
    restaurantRate = json['restaurantRate'];
    restaurantId = json['restaurantId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'comment': comment,
      'foodRate': foodRate,
      'serviceRate': serviceRate,
      'ambianceRate': ambianceRate,
      'noiseLevel': noiseLevel,
      'shishaRate': shishaRate,
      'restaurantRate': restaurantRate,
      'restaurantId': restaurantId
    };
  }

  static List<CreateOrUpdateReviewDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CreateOrUpdateReviewDto>()
        : json
            .map((value) => new CreateOrUpdateReviewDto.fromJson(value))
            .toList();
  }

  static Map<String, CreateOrUpdateReviewDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CreateOrUpdateReviewDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CreateOrUpdateReviewDto.fromJson(value));
    }
    return map;
  }
}
