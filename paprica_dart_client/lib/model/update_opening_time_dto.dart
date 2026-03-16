part of swagger.api;

class UpdateOpeningTimeDto {
  int dayOfWeek = null;

  DateTime fromTime = null;

  DateTime toTime = null;

  UpdateOpeningTimeDto();

  @override
  String toString() {
    return 'UpdateOpeningTimeDto[dayOfWeek=$dayOfWeek, fromTime=$fromTime, toTime=$toTime, ]';
  }

  UpdateOpeningTimeDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    dayOfWeek = json['dayOfWeek'];
    fromTime =
        json['fromTime'] == null ? null : DateTime.parse(json['fromTime']);
    toTime = json['toTime'] == null ? null : DateTime.parse(json['toTime']);
  }

  Map<String, dynamic> toJson() {
    return {
      'dayOfWeek': dayOfWeek,
      'fromTime': fromTime == null ? '' : fromTime.toUtc().toIso8601String(),
      'toTime': toTime == null ? '' : toTime.toUtc().toIso8601String()
    };
  }

  static List<UpdateOpeningTimeDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UpdateOpeningTimeDto>()
        : json
            .map((value) => new UpdateOpeningTimeDto.fromJson(value))
            .toList();
  }

  static Map<String, UpdateOpeningTimeDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdateOpeningTimeDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UpdateOpeningTimeDto.fromJson(value));
    }
    return map;
  }
}
