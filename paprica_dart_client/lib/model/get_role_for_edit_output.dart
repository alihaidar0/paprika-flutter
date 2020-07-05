part of swagger.api;

class GetRoleForEditOutput {
  
  RoleEditDto role = null;
  

  List<FlatPermissionDto> permissions = [];
  

  List<String> grantedPermissionNames = [];
  
  GetRoleForEditOutput();

  @override
  String toString() {
    return 'GetRoleForEditOutput[role=$role, permissions=$permissions, grantedPermissionNames=$grantedPermissionNames, ]';
  }

  GetRoleForEditOutput.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    role =
      
      
      new RoleEditDto.fromJson(json['role'])
;
    permissions =
      FlatPermissionDto.listFromJson(json['permissions'])
;
    grantedPermissionNames =
        (json['grantedPermissionNames'] as List).map((item) => item as String).toList()
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'permissions': permissions,
      'grantedPermissionNames': grantedPermissionNames
     };
  }

  static List<GetRoleForEditOutput> listFromJson(List<dynamic> json) {
    return json == null ? new List<GetRoleForEditOutput>() : json.map((value) => new GetRoleForEditOutput.fromJson(value)).toList();
  }

  static Map<String, GetRoleForEditOutput> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, GetRoleForEditOutput>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new GetRoleForEditOutput.fromJson(value));
    }
    return map;
  }
}

