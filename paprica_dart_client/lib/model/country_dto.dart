part of swagger.api;

class CountryDto {
  
  String name = null;
  

  int id = null;
  
  CountryDto();

  @override
  String toString() {
    return 'CountryDto[name=$name, id=$id, ]';
  }

  CountryDto.fromJson(Map<String, dynamic> json) {
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

  static List<CountryDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<CountryDto>() : json.map((value) => new CountryDto.fromJson(value)).toList();
  }

  static Map<String, CountryDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CountryDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new CountryDto.fromJson(value));
    }
    return map;
  }
}

