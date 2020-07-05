part of swagger.api;

class MealRateDto {
  
  int rate = null;
  

  int id = null;
  
  MealRateDto();

  @override
  String toString() {
    return 'MealRateDto[rate=$rate, id=$id, ]';
  }

  MealRateDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    rate =
        json['rate']
    ;
    id =
        json['id']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'id': id
     };
  }

  static List<MealRateDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<MealRateDto>() : json.map((value) => new MealRateDto.fromJson(value)).toList();
  }

  static Map<String, MealRateDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MealRateDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new MealRateDto.fromJson(value));
    }
    return map;
  }
}

