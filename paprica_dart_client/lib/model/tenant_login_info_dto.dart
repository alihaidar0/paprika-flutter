part of swagger.api;

class TenantLoginInfoDto {
  
  String tenancyName = null;
  

  String name = null;
  

  int id = null;
  
  TenantLoginInfoDto();

  @override
  String toString() {
    return 'TenantLoginInfoDto[tenancyName=$tenancyName, name=$name, id=$id, ]';
  }

  TenantLoginInfoDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    tenancyName =
        json['tenancyName']
    ;
    name =
        json['name']
    ;
    id =
        json['id']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'tenancyName': tenancyName,
      'name': name,
      'id': id
     };
  }

  static List<TenantLoginInfoDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<TenantLoginInfoDto>() : json.map((value) => new TenantLoginInfoDto.fromJson(value)).toList();
  }

  static Map<String, TenantLoginInfoDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, TenantLoginInfoDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new TenantLoginInfoDto.fromJson(value));
    }
    return map;
  }
}

