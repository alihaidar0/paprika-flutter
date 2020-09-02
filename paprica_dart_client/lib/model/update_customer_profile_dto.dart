part of swagger.api;

class UpdateCustomerProfileDto {
  String userName = null;

  String name = null;

  String phoneNumber = null;

  int regionId = null;

  String profileImage = null;

  UpdateCustomerProfileDto();

  @override
  String toString() {
    return 'UpdateCustomerProfileDto[userName=$userName, name=$name, phoneNumber=$phoneNumber, regionId=$regionId, profileImage=$profileImage, ]';
  }

  UpdateCustomerProfileDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userName = json['userName'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    regionId = json['regionId'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'name': name,
      'phoneNumber': phoneNumber,
      'regionId': regionId,
      'profileImage': profileImage
    };
  }

  static List<UpdateCustomerProfileDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UpdateCustomerProfileDto>()
        : json
            .map((value) => new UpdateCustomerProfileDto.fromJson(value))
            .toList();
  }

  static Map<String, UpdateCustomerProfileDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdateCustomerProfileDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UpdateCustomerProfileDto.fromJson(value));
    }
    return map;
  }
}
