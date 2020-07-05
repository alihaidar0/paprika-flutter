part of swagger.api;

class RestaurantRatersDto {
  
  int oneStar = null;
  

  int twoStars = null;
  

  int threeStars = null;
  

  int fourStars = null;
  

  int fiveStars = null;
  
  RestaurantRatersDto();

  @override
  String toString() {
    return 'RestaurantRatersDto[oneStar=$oneStar, twoStars=$twoStars, threeStars=$threeStars, fourStars=$fourStars, fiveStars=$fiveStars, ]';
  }

  RestaurantRatersDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    oneStar =
        json['oneStar']
    ;
    twoStars =
        json['twoStars']
    ;
    threeStars =
        json['threeStars']
    ;
    fourStars =
        json['fourStars']
    ;
    fiveStars =
        json['fiveStars']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'oneStar': oneStar,
      'twoStars': twoStars,
      'threeStars': threeStars,
      'fourStars': fourStars,
      'fiveStars': fiveStars
     };
  }

  static List<RestaurantRatersDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<RestaurantRatersDto>() : json.map((value) => new RestaurantRatersDto.fromJson(value)).toList();
  }

  static Map<String, RestaurantRatersDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RestaurantRatersDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new RestaurantRatersDto.fromJson(value));
    }
    return map;
  }
}

