part of swagger.api;

class TenantDto {
  
  String tenancyName = null;
  

  String name = null;
  

  bool isActive = null;
  

  int id = null;
  
  TenantDto();

  @override
  String toString() {
    return 'TenantDto[tenancyName=$tenancyName, name=$name, isActive=$isActive, id=$id, ]';
  }

  TenantDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    tenancyName =
        json['tenancyName']
    ;
    name =
        json['name']
    ;
    isActive =
        json['isActive']
    ;
    id =
        json['id']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'tenancyName': tenancyName,
      'name': name,
      'isActive': isActive,
      'id': id
     };
  }

  static List<TenantDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<TenantDto>() : json.map((value) => new TenantDto.fromJson(value)).toList();
  }

  static Map<String, TenantDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, TenantDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new TenantDto.fromJson(value));
    }
    return map;
  }
}

