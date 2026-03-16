part of swagger.api;

class RoleEditDto {
  String name = null;

  String displayName = null;

  String description = null;

  bool isStatic = null;

  int id = null;

  RoleEditDto();

  @override
  String toString() {
    return 'RoleEditDto[name=$name, displayName=$displayName, description=$description, isStatic=$isStatic, id=$id, ]';
  }

  RoleEditDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    displayName = json['displayName'];
    description = json['description'];
    isStatic = json['isStatic'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'displayName': displayName,
      'description': description,
      'isStatic': isStatic,
      'id': id
    };
  }

  static List<RoleEditDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<RoleEditDto>()
        : json.map((value) => new RoleEditDto.fromJson(value)).toList();
  }

  static Map<String, RoleEditDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RoleEditDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new RoleEditDto.fromJson(value));
    }
    return map;
  }
}
