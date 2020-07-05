part of swagger.api;

class ChangePasswordDto {
  
  String currentPassword = null;
  

  String newPassword = null;
  
  ChangePasswordDto();

  @override
  String toString() {
    return 'ChangePasswordDto[currentPassword=$currentPassword, newPassword=$newPassword, ]';
  }

  ChangePasswordDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    currentPassword =
        json['currentPassword']
    ;
    newPassword =
        json['newPassword']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPassword': currentPassword,
      'newPassword': newPassword
     };
  }

  static List<ChangePasswordDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<ChangePasswordDto>() : json.map((value) => new ChangePasswordDto.fromJson(value)).toList();
  }

  static Map<String, ChangePasswordDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ChangePasswordDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new ChangePasswordDto.fromJson(value));
    }
    return map;
  }
}

