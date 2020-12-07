part of swagger.api;

class NotificationInfoDto {
  DateTime creationTime = null;

  int state = null;

  //enum stateEnum {  0,  1,  };

  int severity = null;

  //enum severityEnum {  0,  1,  2,  3,  4,  };
  String notificationName = null;
  String data = null;

  NotificationInfoDto();

  @override
  String toString() {
    return 'NotificationInfoDto[creationTime=$creationTime, state=$state, severity=$severity, data=$data, notificationName=$notificationName, ]';
  }

  NotificationInfoDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    //todo you can remove the split functionality when API corrects the date format
    creationTime = json['creationTime'] == null
        ? null
        : DateTime.parse(json['creationTime'].toString().split('.').first);
    state = json['state'];
    severity = json['severity'];
    data = json['data'];
    notificationName = json['notificationName'];
  }

  Map<String, dynamic> toJson() {
    return {
      'creationTime':
          creationTime == null ? '' : creationTime.toUtc().toIso8601String(),
      'state': state,
      'severity': severity,
      'data': data,
      'notificationName': notificationName
    };
  }

  static List<NotificationInfoDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<NotificationInfoDto>()
        : json.map((value) => new NotificationInfoDto.fromJson(value)).toList();
  }

  static Map<String, NotificationInfoDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, NotificationInfoDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new NotificationInfoDto.fromJson(value));
    }
    return map;
  }
}
