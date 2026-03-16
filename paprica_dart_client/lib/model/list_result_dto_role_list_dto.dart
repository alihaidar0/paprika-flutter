part of swagger.api;

class ListResultDtoRoleListDto {
  List<RoleListDto> items = [];

  ListResultDtoRoleListDto();

  @override
  String toString() {
    return 'ListResultDtoRoleListDto[items=$items, ]';
  }

  ListResultDtoRoleListDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    items = RoleListDto.listFromJson(json['items']);
  }

  Map<String, dynamic> toJson() {
    return {'items': items};
  }

  static List<ListResultDtoRoleListDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ListResultDtoRoleListDto>()
        : json
            .map((value) => new ListResultDtoRoleListDto.fromJson(value))
            .toList();
  }

  static Map<String, ListResultDtoRoleListDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ListResultDtoRoleListDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ListResultDtoRoleListDto.fromJson(value));
    }
    return map;
  }
}
