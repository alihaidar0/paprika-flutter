part of swagger.api;

class ConfigurationRegionDto {
  String name = null;

  int cityId = null;

  int id = null;

  ConfigurationRegionDto();

  @override
  String toString() {
    return 'ConfigurationRegionDto[name=$name, cityId=$cityId, id=$id, ]';
  }

  ConfigurationRegionDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    cityId = json['cityId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'cityId': cityId, 'id': id};
  }

  static List<ConfigurationRegionDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ConfigurationRegionDto>()
        : json
            .map((value) => new ConfigurationRegionDto.fromJson(value))
            .toList();
  }

  static Map<String, ConfigurationRegionDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ConfigurationRegionDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ConfigurationRegionDto.fromJson(value));
    }
    return map;
  }
}
