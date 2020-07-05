part of swagger.api;

class CreateCustomerDto {
  
  String name = null;
  

  String userName = null;
  

  String surName = null;
  

  String emailAddress = null;
  

  String profileImage = null;
  

  String password = null;
  

  String phoneNumber = null;
  

  int regionId = null;
  
  CreateCustomerDto();

  @override
  String toString() {
    return 'CreateCustomerDto[name=$name, userName=$userName, surName=$surName, emailAddress=$emailAddress, profileImage=$profileImage, password=$password, phoneNumber=$phoneNumber, regionId=$regionId, ]';
  }

  CreateCustomerDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name =
        json['name']
    ;
    userName =
        json['userName']
    ;
    surName =
        json['surName']
    ;
    emailAddress =
        json['emailAddress']
    ;
    profileImage =
        json['profileImage']
    ;
    password =
        json['password']
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
      'userName': userName,
      'surName': surName,
      'emailAddress': emailAddress,
      'profileImage': profileImage,
      'password': password,
      'phoneNumber': phoneNumber,
      'regionId': regionId
     };
  }

  static List<CreateCustomerDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<CreateCustomerDto>() : json.map((value) => new CreateCustomerDto.fromJson(value)).toList();
  }

  static Map<String, CreateCustomerDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CreateCustomerDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new CreateCustomerDto.fromJson(value));
    }
    return map;
  }
}

