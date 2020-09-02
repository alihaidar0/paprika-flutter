part of swagger.api;

class ChangeSettingDto {
  String name = null;

  String value = null;

  ChangeSettingDto();

  @override
  String toString() {
    return 'ChangeSettingDto[name=$name, value=$value, ]';
  }

  ChangeSettingDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'value': value};
  }

  static List<ChangeSettingDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ChangeSettingDto>()
        : json.map((value) => new ChangeSettingDto.fromJson(value)).toList();
  }

  static Map<String, ChangeSettingDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ChangeSettingDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ChangeSettingDto.fromJson(value));
    }
    return map;
  }
}
