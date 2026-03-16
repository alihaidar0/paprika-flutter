part of swagger.api;

class ResetForgottenPasswordDto {
  String code = null;

  String newPassword = null;

  String userNameOrPhoneNumber = null;

  ResetForgottenPasswordDto();

  @override
  String toString() {
    return 'ResetForgottenPasswordDto[code=$code, newPassword=$newPassword,userNameOrPhoneNumber=$userNameOrPhoneNumber, ]';
  }

  ResetForgottenPasswordDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    code = json['code'];
    newPassword = json['newPassword'];
    userNameOrPhoneNumber = json['userNameOrPhoneNumber'];
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'newPassword': newPassword,
      'userNameOrPhoneNumber': userNameOrPhoneNumber
    };
  }

  static List<ResetForgottenPasswordDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ResetForgottenPasswordDto>()
        : json
            .map((value) => new ResetForgottenPasswordDto.fromJson(value))
            .toList();
  }

  static Map<String, ResetForgottenPasswordDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ResetForgottenPasswordDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ResetForgottenPasswordDto.fromJson(value));
    }
    return map;
  }
}
