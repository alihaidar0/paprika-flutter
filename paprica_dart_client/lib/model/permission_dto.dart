part of swagger.api;

class PermissionDto {
  String name = null;

  String displayName = null;

  String description = null;

  int id = null;

  PermissionDto();

  @override
  String toString() {
    return 'PermissionDto[name=$name, displayName=$displayName, description=$description, id=$id, ]';
  }

  PermissionDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    displayName = json['displayName'];
    description = json['description'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'displayName': displayName,
      'description': description,
      'id': id
    };
  }

  static List<PermissionDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PermissionDto>()
        : json.map((value) => new PermissionDto.fromJson(value)).toList();
  }

  static Map<String, PermissionDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PermissionDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PermissionDto.fromJson(value));
    }
    return map;
  }
}
