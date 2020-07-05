part of swagger.api;

class FlatPermissionDto {
  
  String name = null;
  

  String displayName = null;
  

  String description = null;
  
  FlatPermissionDto();

  @override
  String toString() {
    return 'FlatPermissionDto[name=$name, displayName=$displayName, description=$description, ]';
  }

  FlatPermissionDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name =
        json['name']
    ;
    displayName =
        json['displayName']
    ;
    description =
        json['description']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'displayName': displayName,
      'description': description
     };
  }

  static List<FlatPermissionDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<FlatPermissionDto>() : json.map((value) => new FlatPermissionDto.fromJson(value)).toList();
  }

  static Map<String, FlatPermissionDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, FlatPermissionDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new FlatPermissionDto.fromJson(value));
    }
    return map;
  }
}

