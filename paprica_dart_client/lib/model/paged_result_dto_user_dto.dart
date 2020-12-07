part of swagger.api;

class PagedResultDtoUserDto {
  int totalCount = null;

  List<UserDto> items = [];

  PagedResultDtoUserDto();

  @override
  String toString() {
    return 'PagedResultDtoUserDto[totalCount=$totalCount, items=$items, ]';
  }

  PagedResultDtoUserDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    totalCount = json['totalCount'];
    items = UserDto.listFromJson(json['items']);
  }

  Map<String, dynamic> toJson() {
    return {'totalCount': totalCount, 'items': items};
  }

  static List<PagedResultDtoUserDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PagedResultDtoUserDto>()
        : json
            .map((value) => new PagedResultDtoUserDto.fromJson(value))
            .toList();
  }

  static Map<String, PagedResultDtoUserDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PagedResultDtoUserDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PagedResultDtoUserDto.fromJson(value));
    }
    return map;
  }
}
