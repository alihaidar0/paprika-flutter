part of swagger.api;

class UserNotificationInfoWithNotificationInfo {
  UserNotificationInfo userNotification = null;

  TenantNotificationInfo notification = null;

  UserNotificationInfoWithNotificationInfo();

  @override
  String toString() {
    return 'UserNotificationInfoWithNotificationInfo[userNotification=$userNotification, notification=$notification, ]';
  }

  UserNotificationInfoWithNotificationInfo.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userNotification =
        new UserNotificationInfo.fromJson(json['userNotification']);
    notification = new TenantNotificationInfo.fromJson(json['notification']);
  }

  Map<String, dynamic> toJson() {
    return {'userNotification': userNotification, 'notification': notification};
  }

  static List<UserNotificationInfoWithNotificationInfo> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<UserNotificationInfoWithNotificationInfo>()
        : json
            .map((value) =>
                new UserNotificationInfoWithNotificationInfo.fromJson(value))
            .toList();
  }

  static Map<String, UserNotificationInfoWithNotificationInfo> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UserNotificationInfoWithNotificationInfo>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] =
          new UserNotificationInfoWithNotificationInfo.fromJson(value));
    }
    return map;
  }
}
