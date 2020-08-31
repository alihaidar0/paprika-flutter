part of swagger.api;

class UpdateServiceDto {
  int id = null;

  String name = null;

  String code = null;

  UpdateServiceDto();

  @override
  String toString() {
    return 'UpdateServiceDto[id=$id, name=$name, code=$code, ]';
  }

  UpdateServiceDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'code': code};
  }

  static List<UpdateServiceDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UpdateServiceDto>()
        : json.map((value) => new UpdateServiceDto.fromJson(value)).toList();
  }

  static Map<String, UpdateServiceDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdateServiceDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UpdateServiceDto.fromJson(value));
    }
    return map;
  }
}
