part of swagger.api;

class CreateUserDto {
  String userName = null;

  String name = null;

  String surname = null;

  String emailAddress = null;

  bool isActive = null;

  List<String> roleNames = [];

  String password = null;

  CreateUserDto();

  @override
  String toString() {
    return 'CreateUserDto[userName=$userName, name=$name, surname=$surname, emailAddress=$emailAddress, isActive=$isActive, roleNames=$roleNames, password=$password, ]';
  }

  CreateUserDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userName = json['userName'];
    name = json['name'];
    surname = json['surname'];
    emailAddress = json['emailAddress'];
    isActive = json['isActive'];
    roleNames =
        (json['roleNames'] as List).map((item) => item as String).toList();
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'name': name,
      'surname': surname,
      'emailAddress': emailAddress,
      'isActive': isActive,
      'roleNames': roleNames,
      'password': password
    };
  }

  static List<CreateUserDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CreateUserDto>()
        : json.map((value) => new CreateUserDto.fromJson(value)).toList();
  }

  static Map<String, CreateUserDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CreateUserDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CreateUserDto.fromJson(value));
    }
    return map;
  }
}
