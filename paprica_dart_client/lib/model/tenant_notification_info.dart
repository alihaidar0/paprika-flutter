part of swagger.api;

class TenantNotificationInfo {
  int tenantId = null;

  String notificationName = null;

  String data = null;

  String dataTypeName = null;

  String entityTypeName = null;

  String entityTypeAssemblyQualifiedName = null;

  String entityId = null;

  int severity = null;
  //enum severityEnum {  0,  1,  2,  3,  4,  };

  DateTime creationTime = null;

  int creatorUserId = null;

  String id = null;

  TenantNotificationInfo();

  @override
  String toString() {
    return 'TenantNotificationInfo[tenantId=$tenantId, notificationName=$notificationName, data=$data, dataTypeName=$dataTypeName, entityTypeName=$entityTypeName, entityTypeAssemblyQualifiedName=$entityTypeAssemblyQualifiedName, entityId=$entityId, severity=$severity, creationTime=$creationTime, creatorUserId=$creatorUserId, id=$id, ]';
  }

  TenantNotificationInfo.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    tenantId = json['tenantId'];
    notificationName = json['notificationName'];
    data = json['data'];
    dataTypeName = json['dataTypeName'];
    entityTypeName = json['entityTypeName'];
    entityTypeAssemblyQualifiedName = json['entityTypeAssemblyQualifiedName'];
    entityId = json['entityId'];
    severity = json['severity'];
    creationTime = json['creationTime'] == null
        ? null
        : DateTime.parse(json['creationTime']);
    creatorUserId = json['creatorUserId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'tenantId': tenantId,
      'notificationName': notificationName,
      'data': data,
      'dataTypeName': dataTypeName,
      'entityTypeName': entityTypeName,
      'entityTypeAssemblyQualifiedName': entityTypeAssemblyQualifiedName,
      'entityId': entityId,
      'severity': severity,
      'creationTime':
          creationTime == null ? '' : creationTime.toUtc().toIso8601String(),
      'creatorUserId': creatorUserId,
      'id': id
    };
  }

  static List<TenantNotificationInfo> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<TenantNotificationInfo>()
        : json
            .map((value) => new TenantNotificationInfo.fromJson(value))
            .toList();
  }

  static Map<String, TenantNotificationInfo> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, TenantNotificationInfo>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new TenantNotificationInfo.fromJson(value));
    }
    return map;
  }
}
