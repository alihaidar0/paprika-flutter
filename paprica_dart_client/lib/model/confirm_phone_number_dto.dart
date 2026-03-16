part of swagger.api;

class ConfirmPhoneNumberDto {
  String code = null;

  ConfirmPhoneNumberDto();

  @override
  String toString() {
    return 'ConfirmPhoneNumberDto[code=$code, ]';
  }

  ConfirmPhoneNumberDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    return {'code': code};
  }

  static List<ConfirmPhoneNumberDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ConfirmPhoneNumberDto>()
        : json
            .map((value) => new ConfirmPhoneNumberDto.fromJson(value))
            .toList();
  }

  static Map<String, ConfirmPhoneNumberDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ConfirmPhoneNumberDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ConfirmPhoneNumberDto.fromJson(value));
    }
    return map;
  }
}
