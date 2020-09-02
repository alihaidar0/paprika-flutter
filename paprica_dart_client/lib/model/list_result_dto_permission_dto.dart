part of swagger.api;

class ListResultDtoPermissionDto {
  List<PermissionDto> items = [];

  ListResultDtoPermissionDto();

  @override
  String toString() {
    return 'ListResultDtoPermissionDto[items=$items, ]';
  }

  ListResultDtoPermissionDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    items = PermissionDto.listFromJson(json['items']);
  }

  Map<String, dynamic> toJson() {
    return {'items': items};
  }

  static List<ListResultDtoPermissionDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ListResultDtoPermissionDto>()
        : json
            .map((value) => new ListResultDtoPermissionDto.fromJson(value))
            .toList();
  }

  static Map<String, ListResultDtoPermissionDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ListResultDtoPermissionDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ListResultDtoPermissionDto.fromJson(value));
    }
    return map;
  }
}
