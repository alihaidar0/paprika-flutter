part of swagger.api;

class RoleDto {
  String name = null;

  String displayName = null;

  String normalizedName = null;

  String description = null;

  List<String> permissions = [];

  int id = null;

  RoleDto();

  @override
  String toString() {
    return 'RoleDto[name=$name, displayName=$displayName, normalizedName=$normalizedName, description=$description, permissions=$permissions, id=$id, ]';
  }

  RoleDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    displayName = json['displayName'];
    normalizedName = json['normalizedName'];
    description = json['description'];
    permissions =
        (json['permissions'] as List).map((item) => item as String).toList();
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'displayName': displayName,
      'normalizedName': normalizedName,
      'description': description,
      'permissions': permissions,
      'id': id
    };
  }

  static List<RoleDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<RoleDto>()
        : json.map((value) => new RoleDto.fromJson(value)).toList();
  }

  static Map<String, RoleDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RoleDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new RoleDto.fromJson(value));
    }
    return map;
  }
}
