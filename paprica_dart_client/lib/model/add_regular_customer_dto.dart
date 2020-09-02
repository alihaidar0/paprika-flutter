part of swagger.api;

class AddRegularCustomerDto {
  int customerId = null;

  AddRegularCustomerDto();

  @override
  String toString() {
    return 'AddRegularCustomerDto[customerId=$customerId, ]';
  }

  AddRegularCustomerDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    customerId = json['customerId'];
  }

  Map<String, dynamic> toJson() {
    return {'customerId': customerId};
  }

  static List<AddRegularCustomerDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<AddRegularCustomerDto>()
        : json
            .map((value) => new AddRegularCustomerDto.fromJson(value))
            .toList();
  }

  static Map<String, AddRegularCustomerDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AddRegularCustomerDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AddRegularCustomerDto.fromJson(value));
    }
    return map;
  }
}
