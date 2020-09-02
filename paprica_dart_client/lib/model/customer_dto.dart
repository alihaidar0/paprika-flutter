part of swagger.api;

class CustomerDto {
  int userId = null;

  bool isActive = null;

  String profileImage = null;

  String fullName = null;

  String emailaddress = null;

  String phoneNumber = null;

  int id = null;

  CustomerDto();

  @override
  String toString() {
    return 'CustomerDto[userId=$userId, isActive=$isActive, profileImage=$profileImage, fullName=$fullName, emailaddress=$emailaddress, phoneNumber=$phoneNumber, id=$id, ]';
  }

  CustomerDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userId = json['userId'];
    isActive = json['isActive'];
    profileImage = json['profileImage'];
    fullName = json['fullName'];
    emailaddress = json['emailaddress'];
    phoneNumber = json['phoneNumber'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'isActive': isActive,
      'profileImage': profileImage,
      'fullName': fullName,
      'emailaddress': emailaddress,
      'phoneNumber': phoneNumber,
      'id': id
    };
  }

  static List<CustomerDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CustomerDto>()
        : json.map((value) => new CustomerDto.fromJson(value)).toList();
  }

  static Map<String, CustomerDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CustomerDto.fromJson(value));
    }
    return map;
  }
}
