part of swagger.api;

class OpeningTimeDto {
  
  int dayOfWeek = null;
  

  DateTime fromTime = null;
  

  DateTime toTime = null;
  

  int id = null;
  
  OpeningTimeDto();

  @override
  String toString() {
    return 'OpeningTimeDto[dayOfWeek=$dayOfWeek, fromTime=$fromTime, toTime=$toTime, id=$id, ]';
  }

  OpeningTimeDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    dayOfWeek =
        json['dayOfWeek']
    ;
    fromTime = json['fromTime'] == null ? null : DateTime.parse(json['fromTime']);
    toTime = json['toTime'] == null ? null : DateTime.parse(json['toTime']);
    id =
        json['id']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'dayOfWeek': dayOfWeek,
      'fromTime': fromTime == null ? '' : fromTime.toUtc().toIso8601String(),
      'toTime': toTime == null ? '' : toTime.toUtc().toIso8601String(),
      'id': id
     };
  }

  static List<OpeningTimeDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<OpeningTimeDto>() : json.map((value) => new OpeningTimeDto.fromJson(value)).toList();
  }

  static Map<String, OpeningTimeDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, OpeningTimeDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new OpeningTimeDto.fromJson(value));
    }
    return map;
  }
}

