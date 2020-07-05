part of swagger.api;

class ReviewDto {
  
  String comment = null;
  

  double foodRate = null;
  

  double serviceRate = null;
  

  double ambianceRate = null;
  

  int noiseLevel = null;
  //enum noiseLevelEnum {  1,  2,  3,  };

  double shishaRate = null;
  

  double restaurantRate = null;
  

  int status = null;
  //enum statusEnum {  1,  2,  3,  };

  int restaurantId = null;
  

  int customerId = null;
  

  int id = null;
  
  ReviewDto();

  @override
  String toString() {
    return 'ReviewDto[comment=$comment, foodRate=$foodRate, serviceRate=$serviceRate, ambianceRate=$ambianceRate, noiseLevel=$noiseLevel, shishaRate=$shishaRate, restaurantRate=$restaurantRate, status=$status, restaurantId=$restaurantId, customerId=$customerId, id=$id, ]';
  }

  ReviewDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    comment =
        json['comment']
    ;
    foodRate =
        json['foodRate']
    ;
    serviceRate =
        json['serviceRate']
    ;
    ambianceRate =
        json['ambianceRate']
    ;
    noiseLevel =
        json['noiseLevel']
    ;
    shishaRate =
        json['shishaRate']
    ;
    restaurantRate =
        json['restaurantRate']
    ;
    status =
        json['status']
    ;
    restaurantId =
        json['restaurantId']
    ;
    customerId =
        json['customerId']
    ;
    id =
        json['id']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'foodRate': foodRate,
      'serviceRate': serviceRate,
      'ambianceRate': ambianceRate,
      'noiseLevel': noiseLevel,
      'shishaRate': shishaRate,
      'restaurantRate': restaurantRate,
      'status': status,
      'restaurantId': restaurantId,
      'customerId': customerId,
      'id': id
     };
  }

  static List<ReviewDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<ReviewDto>() : json.map((value) => new ReviewDto.fromJson(value)).toList();
  }

  static Map<String, ReviewDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ReviewDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new ReviewDto.fromJson(value));
    }
    return map;
  }
}

