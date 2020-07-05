part of swagger.api;

class UpdatePhoneNumberDto {
  
  String phoneNumber = null;
  
  UpdatePhoneNumberDto();

  @override
  String toString() {
    return 'UpdatePhoneNumberDto[phoneNumber=$phoneNumber, ]';
  }

  UpdatePhoneNumberDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    phoneNumber =
        json['phoneNumber']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber
     };
  }

  static List<UpdatePhoneNumberDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<UpdatePhoneNumberDto>() : json.map((value) => new UpdatePhoneNumberDto.fromJson(value)).toList();
  }

  static Map<String, UpdatePhoneNumberDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdatePhoneNumberDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new UpdatePhoneNumberDto.fromJson(value));
    }
    return map;
  }
}

