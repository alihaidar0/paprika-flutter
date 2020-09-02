part of swagger.api;

class UserNotificationInfo {
  int tenantId = null;

  int userId = null;

  String tenantNotificationId = null;

  int state = null;
  //enum stateEnum {  0,  1,  };

  DateTime creationTime = null;

  String id = null;

  UserNotificationInfo();

  @override
  String toString() {
    return 'UserNotificationInfo[tenantId=$tenantId, userId=$userId, tenantNotificationId=$tenantNotificationId, state=$state, creationTime=$creationTime, id=$id, ]';
  }

  UserNotificationInfo.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    tenantId = json['tenantId'];
    userId = json['userId'];
    tenantNotificationId = json['tenantNotificationId'];
    state = json['state'];
    creationTime = json['creationTime'] == null
        ? null
        : DateTime.parse(json['creationTime']);
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'tenantId': tenantId,
      'userId': userId,
      'tenantNotificationId': tenantNotificationId,
      'state': state,
      'creationTime':
          creationTime == null ? '' : creationTime.toUtc().toIso8601String(),
      'id': id
    };
  }

  static List<UserNotificationInfo> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UserNotificationInfo>()
        : json
            .map((value) => new UserNotificationInfo.fromJson(value))
            .toList();
  }

  static Map<String, UserNotificationInfo> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UserNotificationInfo>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UserNotificationInfo.fromJson(value));
    }
    return map;
  }
}
