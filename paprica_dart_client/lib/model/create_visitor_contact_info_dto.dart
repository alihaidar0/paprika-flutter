part of swagger.api;

class CreateVisitorContactInfoDto {
  String name = null;

  String emailOrPhoneNumber = null;

  String file = null;

  CreateVisitorContactInfoDto();

  @override
  String toString() {
    return 'CreateVisitorContactInfoDto[name=$name, emailOrPhoneNumber=$emailOrPhoneNumber, file=$file, ]';
  }

  CreateVisitorContactInfoDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    emailOrPhoneNumber = json['emailOrPhoneNumber'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'emailOrPhoneNumber': emailOrPhoneNumber,
      'file': file
    };
  }

  static List<CreateVisitorContactInfoDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CreateVisitorContactInfoDto>()
        : json
            .map((value) => new CreateVisitorContactInfoDto.fromJson(value))
            .toList();
  }

  static Map<String, CreateVisitorContactInfoDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CreateVisitorContactInfoDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CreateVisitorContactInfoDto.fromJson(value));
    }
    return map;
  }
}
