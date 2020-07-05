part of swagger.api;

class ConfigurationCityDto {
  
  String name = null;
  

  int countryId = null;
  

  int id = null;
  
  ConfigurationCityDto();

  @override
  String toString() {
    return 'ConfigurationCityDto[name=$name, countryId=$countryId, id=$id, ]';
  }

  ConfigurationCityDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name =
        json['name']
    ;
    countryId =
        json['countryId']
    ;
    id =
        json['id']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'countryId': countryId,
      'id': id
     };
  }

  static List<ConfigurationCityDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<ConfigurationCityDto>() : json.map((value) => new ConfigurationCityDto.fromJson(value)).toList();
  }

  static Map<String, ConfigurationCityDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ConfigurationCityDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new ConfigurationCityDto.fromJson(value));
    }
    return map;
  }
}

