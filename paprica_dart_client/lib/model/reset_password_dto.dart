part of swagger.api;

class ResetPasswordDto {
  
  String adminPassword = null;
  

  int userId = null;
  

  String newPassword = null;
  
  ResetPasswordDto();

  @override
  String toString() {
    return 'ResetPasswordDto[adminPassword=$adminPassword, userId=$userId, newPassword=$newPassword, ]';
  }

  ResetPasswordDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    adminPassword =
        json['adminPassword']
    ;
    userId =
        json['userId']
    ;
    newPassword =
        json['newPassword']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'adminPassword': adminPassword,
      'userId': userId,
      'newPassword': newPassword
     };
  }

  static List<ResetPasswordDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<ResetPasswordDto>() : json.map((value) => new ResetPasswordDto.fromJson(value)).toList();
  }

  static Map<String, ResetPasswordDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ResetPasswordDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new ResetPasswordDto.fromJson(value));
    }
    return map;
  }
}

