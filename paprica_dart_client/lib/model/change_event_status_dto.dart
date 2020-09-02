part of swagger.api;

class ChangeEventStatusDto {
  bool isActive = null;

  int id = null;

  ChangeEventStatusDto();

  @override
  String toString() {
    return 'ChangeEventStatusDto[isActive=$isActive, id=$id, ]';
  }

  ChangeEventStatusDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    isActive = json['isActive'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {'isActive': isActive, 'id': id};
  }

  static List<ChangeEventStatusDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ChangeEventStatusDto>()
        : json
            .map((value) => new ChangeEventStatusDto.fromJson(value))
            .toList();
  }

  static Map<String, ChangeEventStatusDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ChangeEventStatusDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ChangeEventStatusDto.fromJson(value));
    }
    return map;
  }
}
