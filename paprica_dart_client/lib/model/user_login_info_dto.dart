part of swagger.api;

class UserLoginInfoDto {
  String name = null;

  String surname = null;

  String userName = null;

  String emailAddress = null;

  int id = null;

  UserLoginInfoDto();

  @override
  String toString() {
    return 'UserLoginInfoDto[name=$name, surname=$surname, userName=$userName, emailAddress=$emailAddress, id=$id, ]';
  }

  UserLoginInfoDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    surname = json['surname'];
    userName = json['userName'];
    emailAddress = json['emailAddress'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'userName': userName,
      'emailAddress': emailAddress,
      'id': id
    };
  }

  static List<UserLoginInfoDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UserLoginInfoDto>()
        : json.map((value) => new UserLoginInfoDto.fromJson(value)).toList();
  }

  static Map<String, UserLoginInfoDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UserLoginInfoDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UserLoginInfoDto.fromJson(value));
    }
    return map;
  }
}
