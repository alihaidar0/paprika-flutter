part of swagger.api;

class CustomerInfoDto {
  String name = null;
  String phoneNumber = null;
  bool isPhoneNumberConfirmed = null;

  CustomerInfoDto();

  @override
  String toString() {
    return 'CustomerInfoDto[name=$name, phoneNumber=$phoneNumber, isPhoneNumberConfirmed=$isPhoneNumberConfirmed, ]';
  }

  CustomerInfoDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    isPhoneNumberConfirmed = json['isPhoneNumberConfirmed'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'isPhoneNumberConfirmed': isPhoneNumberConfirmed
    };
  }

  static List<CustomerInfoDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CustomerInfoDto>()
        : json.map((value) => new CustomerInfoDto.fromJson(value)).toList();
  }

  static Map<String, CustomerInfoDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerInfoDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CustomerInfoDto.fromJson(value));
    }
    return map;
  }
}
