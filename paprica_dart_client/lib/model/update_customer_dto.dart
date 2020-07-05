part of swagger.api;

class UpdateCustomerDto {
  
  String name = null;
  

  String profileImage = null;
  

  String phoneNumber = null;
  

  int regionId = null;
  
  UpdateCustomerDto();

  @override
  String toString() {
    return 'UpdateCustomerDto[name=$name, profileImage=$profileImage, phoneNumber=$phoneNumber, regionId=$regionId, ]';
  }

  UpdateCustomerDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name =
        json['name']
    ;
    profileImage =
        json['profileImage']
    ;
    phoneNumber =
        json['phoneNumber']
    ;
    regionId =
        json['regionId']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profileImage': profileImage,
      'phoneNumber': phoneNumber,
      'regionId': regionId
     };
  }

  static List<UpdateCustomerDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<UpdateCustomerDto>() : json.map((value) => new UpdateCustomerDto.fromJson(value)).toList();
  }

  static Map<String, UpdateCustomerDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdateCustomerDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new UpdateCustomerDto.fromJson(value));
    }
    return map;
  }
}

