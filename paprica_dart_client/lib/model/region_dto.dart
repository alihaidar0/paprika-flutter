part of swagger.api;

class RegionDto {
  String name = null;

  int id = null;

  RegionDto();

  @override
  String toString() {
    return 'RegionDto[name=$name, id=$id, ]';
  }

  RegionDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'id': id};
  }

  static List<RegionDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<RegionDto>()
        : json.map((value) => new RegionDto.fromJson(value)).toList();
  }

  static Map<String, RegionDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RegionDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new RegionDto.fromJson(value));
    }
    return map;
  }
}
