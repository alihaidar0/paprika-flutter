part of swagger.api;

class ListResultDtoRoleDto {
  List<RoleDto> items = [];

  ListResultDtoRoleDto();

  @override
  String toString() {
    return 'ListResultDtoRoleDto[items=$items, ]';
  }

  ListResultDtoRoleDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    items = RoleDto.listFromJson(json['items']);
  }

  Map<String, dynamic> toJson() {
    return {'items': items};
  }

  static List<ListResultDtoRoleDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ListResultDtoRoleDto>()
        : json
            .map((value) => new ListResultDtoRoleDto.fromJson(value))
            .toList();
  }

  static Map<String, ListResultDtoRoleDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ListResultDtoRoleDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ListResultDtoRoleDto.fromJson(value));
    }
    return map;
  }
}
