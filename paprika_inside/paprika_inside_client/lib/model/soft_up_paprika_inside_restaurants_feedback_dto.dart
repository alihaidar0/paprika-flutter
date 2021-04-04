part of swagger.api;

class SoftUpPaprikaInsideRestaurantsFeedbackDto {
  String additionalInfo = null;

  double rate = null;

  // range from 0 to 5//
  SoftUpPaprikaInsideRestaurantsFeedbackDto();

  @override
  String toString() {
    return 'SoftUpPaprikaInsideRestaurantsFeedbackDto[additionalInfo=$additionalInfo, rate=$rate, ]';
  }

  SoftUpPaprikaInsideRestaurantsFeedbackDto.fromJson(
      Map<String, dynamic> json) {
    if (json == null) return;
    additionalInfo = json['additionalInfo'];
    rate = json['rate'] == null ? null : json['rate'].toDouble();
  }

  Map<String, dynamic> toJson() {
    return {'additionalInfo': additionalInfo, 'rate': rate};
  }

  static List<SoftUpPaprikaInsideRestaurantsFeedbackDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<SoftUpPaprikaInsideRestaurantsFeedbackDto>()
        : json
            .map((value) =>
                new SoftUpPaprikaInsideRestaurantsFeedbackDto.fromJson(value))
            .toList();
  }

  static Map<String, SoftUpPaprikaInsideRestaurantsFeedbackDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SoftUpPaprikaInsideRestaurantsFeedbackDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] =
          new SoftUpPaprikaInsideRestaurantsFeedbackDto.fromJson(value));
    }
    return map;
  }
}
