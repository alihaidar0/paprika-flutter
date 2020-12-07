part of swagger.api;

class ServiceDto {
  int id = null;

  String name = null;

  String code = null;

  ServiceDto();

  @override
  String toString() {
    return 'ServiceDto[id=$id, name=$name, code=$code, ]';
  }

  ServiceDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'code': code};
  }

  static List<ServiceDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ServiceDto>()
        : json.map((value) => new ServiceDto.fromJson(value)).toList();
  }

  static Map<String, ServiceDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ServiceDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ServiceDto.fromJson(value));
    }
    return map;
  }
}
