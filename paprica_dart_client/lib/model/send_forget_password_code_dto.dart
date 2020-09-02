part of swagger.api;

class SendForgetPasswordCodeDto {
  String userNameOrPhoneNumber = null;

  SendForgetPasswordCodeDto();

  @override
  String toString() {
    return 'SendForgetPasswordCodeDto[userNameOrPhoneNumber=$userNameOrPhoneNumber, ]';
  }

  SendForgetPasswordCodeDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userNameOrPhoneNumber = json['userNameOrPhoneNumber'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userNameOrPhoneNumber': userNameOrPhoneNumber,
    };
  }

  static List<SendForgetPasswordCodeDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<SendForgetPasswordCodeDto>()
        : json
            .map((value) => new SendForgetPasswordCodeDto.fromJson(value))
            .toList();
  }

  static Map<String, SendForgetPasswordCodeDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SendForgetPasswordCodeDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new SendForgetPasswordCodeDto.fromJson(value));
    }
    return map;
  }
}
