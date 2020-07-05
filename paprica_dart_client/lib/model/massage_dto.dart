part of swagger.api;

class MassageDto {
  
  String message = null;
  
  MassageDto();

  @override
  String toString() {
    return 'MassageDto[message=$message, ]';
  }

  MassageDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    message =
        json['message']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message
     };
  }

  static List<MassageDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<MassageDto>() : json.map((value) => new MassageDto.fromJson(value)).toList();
  }

  static Map<String, MassageDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MassageDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new MassageDto.fromJson(value));
    }
    return map;
  }
}

