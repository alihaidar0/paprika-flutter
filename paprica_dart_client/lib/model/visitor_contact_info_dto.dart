part of swagger.api;

class VisitorContactInfoDto {
  
  int id = null;
  

  String name = null;
  

  String emailOrPhoneNumber = null;
  

  String file = null;
  
  VisitorContactInfoDto();

  @override
  String toString() {
    return 'VisitorContactInfoDto[id=$id, name=$name, emailOrPhoneNumber=$emailOrPhoneNumber, file=$file, ]';
  }

  VisitorContactInfoDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id =
        json['id']
    ;
    name =
        json['name']
    ;
    emailOrPhoneNumber =
        json['emailOrPhoneNumber']
    ;
    file =
        json['file']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'emailOrPhoneNumber': emailOrPhoneNumber,
      'file': file
     };
  }

  static List<VisitorContactInfoDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<VisitorContactInfoDto>() : json.map((value) => new VisitorContactInfoDto.fromJson(value)).toList();
  }

  static Map<String, VisitorContactInfoDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, VisitorContactInfoDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new VisitorContactInfoDto.fromJson(value));
    }
    return map;
  }
}

