part of swagger.api;

class ConfigurationCountryDto {
  String name = null;

  int id = null;

  ConfigurationCountryDto();

  @override
  String toString() {
    return 'ConfigurationCountryDto[name=$name, id=$id, ]';
  }

  ConfigurationCountryDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'id': id};
  }

  static List<ConfigurationCountryDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ConfigurationCountryDto>()
        : json
            .map((value) => new ConfigurationCountryDto.fromJson(value))
            .toList();
  }

  static Map<String, ConfigurationCountryDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ConfigurationCountryDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ConfigurationCountryDto.fromJson(value));
    }
    return map;
  }
}
