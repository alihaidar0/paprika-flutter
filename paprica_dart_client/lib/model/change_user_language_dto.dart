part of swagger.api;

class ChangeUserLanguageDto {
  
  String languageName = null;
  
  ChangeUserLanguageDto();

  @override
  String toString() {
    return 'ChangeUserLanguageDto[languageName=$languageName, ]';
  }

  ChangeUserLanguageDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    languageName =
        json['languageName']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'languageName': languageName
     };
  }

  static List<ChangeUserLanguageDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<ChangeUserLanguageDto>() : json.map((value) => new ChangeUserLanguageDto.fromJson(value)).toList();
  }

  static Map<String, ChangeUserLanguageDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ChangeUserLanguageDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new ChangeUserLanguageDto.fromJson(value));
    }
    return map;
  }
}

