part of swagger.api;

class UserDto {
  String userName = null;

  String name = null;

  String surname = null;

  String emailAddress = null;

  bool isActive = null;

  String fullName = null;

  DateTime lastLoginTime = null;

  DateTime creationTime = null;

  List<String> roleNames = [];

  int id = null;

  UserDto();

  @override
  String toString() {
    return 'UserDto[userName=$userName, name=$name, surname=$surname, emailAddress=$emailAddress, isActive=$isActive, fullName=$fullName, lastLoginTime=$lastLoginTime, creationTime=$creationTime, roleNames=$roleNames, id=$id, ]';
  }

  UserDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userName = json['userName'];
    name = json['name'];
    surname = json['surname'];
    emailAddress = json['emailAddress'];
    isActive = json['isActive'];
    fullName = json['fullName'];
    lastLoginTime = json['lastLoginTime'] == null
        ? null
        : DateTime.parse(json['lastLoginTime']);
    creationTime = json['creationTime'] == null
        ? null
        : DateTime.parse(json['creationTime']);
    roleNames =
        (json['roleNames'] as List).map((item) => item as String).toList();
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'name': name,
      'surname': surname,
      'emailAddress': emailAddress,
      'isActive': isActive,
      'fullName': fullName,
      'lastLoginTime':
          lastLoginTime == null ? '' : lastLoginTime.toUtc().toIso8601String(),
      'creationTime':
          creationTime == null ? '' : creationTime.toUtc().toIso8601String(),
      'roleNames': roleNames,
      'id': id
    };
  }

  static List<UserDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UserDto>()
        : json.map((value) => new UserDto.fromJson(value)).toList();
  }

  static Map<String, UserDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UserDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UserDto.fromJson(value));
    }
    return map;
  }
}
