part of swagger.api;

class NotificationsInfoDto {
  List<NotificationInfoDto> notifications = [];

  int count = null;

  NotificationsInfoDto();

  @override
  String toString() {
    return 'NotificationsInfoDto[notifications=$notifications, count=$count, ]';
  }

  NotificationsInfoDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    notifications = NotificationInfoDto.listFromJson(json['notifications']);
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    return {'notifications': notifications, 'count': count};
  }

  static List<NotificationsInfoDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<NotificationsInfoDto>()
        : json
            .map((value) => new NotificationsInfoDto.fromJson(value))
            .toList();
  }

  static Map<String, NotificationsInfoDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, NotificationsInfoDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new NotificationsInfoDto.fromJson(value));
    }
    return map;
  }
}
