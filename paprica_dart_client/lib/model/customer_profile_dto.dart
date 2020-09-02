part of swagger.api;

class CustomerProfileDto {
  String userName = null;

  String name = null;

  String phoneNumber = null;

  int regionId = null;

  String profileImage = null;

  bool isExternalUser = null;
  CustomerProfileDto();

  @override
  String toString() {
    return 'CustomerProfileDto[userName=$userName, name=$name, phoneNumber=$phoneNumber, regionId=$regionId, profileImage=$profileImage,isExternalUser=$isExternalUser ]';
  }

  CustomerProfileDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userName = json['userName'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    regionId = json['regionId'];
    profileImage = json['profileImage'];
    isExternalUser = json['isExternalUser'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'name': name,
      'phoneNumber': phoneNumber,
      'regionId': regionId,
      'profileImage': profileImage,
      'isExternalUser': isExternalUser
    };
  }

  static List<CustomerProfileDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CustomerProfileDto>()
        : json.map((value) => new CustomerProfileDto.fromJson(value)).toList();
  }

  static Map<String, CustomerProfileDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerProfileDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CustomerProfileDto.fromJson(value));
    }
    return map;
  }
}
