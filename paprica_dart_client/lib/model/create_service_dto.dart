part of swagger.api;

class CreateServiceDto {
  String name = null;

  String code = null;

  CreateServiceDto();

  @override
  String toString() {
    return 'CreateServiceDto[name=$name, code=$code, ]';
  }

  CreateServiceDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'code': code};
  }

  static List<CreateServiceDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CreateServiceDto>()
        : json.map((value) => new CreateServiceDto.fromJson(value)).toList();
  }

  static Map<String, CreateServiceDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CreateServiceDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CreateServiceDto.fromJson(value));
    }
    return map;
  }
}
