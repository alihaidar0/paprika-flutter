part of swagger.api;

class RoleListDto {
  
  String name = null;
  

  String displayName = null;
  

  bool isStatic = null;
  

  bool isDefault = null;
  

  DateTime creationTime = null;
  

  int id = null;
  
  RoleListDto();

  @override
  String toString() {
    return 'RoleListDto[name=$name, displayName=$displayName, isStatic=$isStatic, isDefault=$isDefault, creationTime=$creationTime, id=$id, ]';
  }

  RoleListDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name =
        json['name']
    ;
    displayName =
        json['displayName']
    ;
    isStatic =
        json['isStatic']
    ;
    isDefault =
        json['isDefault']
    ;
    creationTime = json['creationTime'] == null ? null : DateTime.parse(json['creationTime']);
    id =
        json['id']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'displayName': displayName,
      'isStatic': isStatic,
      'isDefault': isDefault,
      'creationTime': creationTime == null ? '' : creationTime.toUtc().toIso8601String(),
      'id': id
     };
  }

  static List<RoleListDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<RoleListDto>() : json.map((value) => new RoleListDto.fromJson(value)).toList();
  }

  static Map<String, RoleListDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RoleListDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new RoleListDto.fromJson(value));
    }
    return map;
  }
}

