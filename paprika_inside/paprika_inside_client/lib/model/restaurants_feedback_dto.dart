part of swagger_inside.api;

class RestaurantsFeedbackDto {
  String additionalInfo = null;

  double rate = null;

  // range from 0 to 5//
  RestaurantsFeedbackDto();

  @override
  String toString() {
    return 'RestaurantsFeedbackDto[additionalInfo=$additionalInfo, rate=$rate, ]';
  }

  RestaurantsFeedbackDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    additionalInfo = json['additionalInfo'];
    rate = json['rate'] == null ? null : json['rate'].toDouble();
  }

  Map<String, dynamic> toJson() {
    return {'additionalInfo': additionalInfo, 'rate': rate};
  }

  static List<RestaurantsFeedbackDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<RestaurantsFeedbackDto>()
        : json
            .map((value) => new RestaurantsFeedbackDto.fromJson(value))
            .toList();
  }

  static Map<String, RestaurantsFeedbackDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RestaurantsFeedbackDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new RestaurantsFeedbackDto.fromJson(value));
    }
    return map;
  }
}
