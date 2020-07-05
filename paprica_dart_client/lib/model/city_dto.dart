part of swagger.api;

class CityDto {
  
  String name = null;
  

  int id = null;
  
  CityDto();

  @override
  String toString() {
    return 'CityDto[name=$name, id=$id, ]';
  }

  CityDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name =
        json['name']
    ;
    id =
        json['id']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id
     };
  }

  static List<CityDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<CityDto>() : json.map((value) => new CityDto.fromJson(value)).toList();
  }

  static Map<String, CityDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CityDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new CityDto.fromJson(value));
    }
    return map;
  }
}

