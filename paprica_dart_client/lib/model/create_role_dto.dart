part of swagger.api;

class CreateRoleDto {
  
  String name = null;
  

  String displayName = null;
  

  String normalizedName = null;
  

  String description = null;
  

  List<String> permissions = [];
  
  CreateRoleDto();

  @override
  String toString() {
    return 'CreateRoleDto[name=$name, displayName=$displayName, normalizedName=$normalizedName, description=$description, permissions=$permissions, ]';
  }

  CreateRoleDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name =
        json['name']
    ;
    displayName =
        json['displayName']
    ;
    normalizedName =
        json['normalizedName']
    ;
    description =
        json['description']
    ;
    permissions =
        (json['permissions'] as List).map((item) => item as String).toList()
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'displayName': displayName,
      'normalizedName': normalizedName,
      'description': description,
      'permissions': permissions
     };
  }

  static List<CreateRoleDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<CreateRoleDto>() : json.map((value) => new CreateRoleDto.fromJson(value)).toList();
  }

  static Map<String, CreateRoleDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CreateRoleDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new CreateRoleDto.fromJson(value));
    }
    return map;
  }
}

