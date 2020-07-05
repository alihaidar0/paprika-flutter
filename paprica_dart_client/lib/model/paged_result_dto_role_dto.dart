part of swagger.api;

class PagedResultDtoRoleDto {
  
  int totalCount = null;
  

  List<RoleDto> items = [];
  
  PagedResultDtoRoleDto();

  @override
  String toString() {
    return 'PagedResultDtoRoleDto[totalCount=$totalCount, items=$items, ]';
  }

  PagedResultDtoRoleDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    totalCount =
        json['totalCount']
    ;
    items =
      RoleDto.listFromJson(json['items'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'totalCount': totalCount,
      'items': items
     };
  }

  static List<PagedResultDtoRoleDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<PagedResultDtoRoleDto>() : json.map((value) => new PagedResultDtoRoleDto.fromJson(value)).toList();
  }

  static Map<String, PagedResultDtoRoleDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PagedResultDtoRoleDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new PagedResultDtoRoleDto.fromJson(value));
    }
    return map;
  }
}

