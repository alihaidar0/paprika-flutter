part of swagger.api;

class CustomerOldPickupDto {
  int id = null;

  int restaurantId = null;

  DateTime date = null;

  int status = null;

  String restaurantImage = null;

  String restaurantName = null;

  UpdatePickupRequestDto updateRequest = null;

  CustomerOldPickupDto();

  @override
  String toString() {
    return 'CustomerOldPickupDto[id=$id, restaurantId=$restaurantId, date=$date, status=$status, restaurantImage=$restaurantImage, restaurantName=$restaurantName, updateRequest=$updateRequest, ]';
  }

  CustomerOldPickupDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    restaurantId = json['restaurantId'];
    date = json['date'] == null ? null : DateTime.parse(json['date']);
    status = json['status'];
    restaurantImage = json['restaurantImage'];
    restaurantName = json['restaurantName'];
    updateRequest =
    new UpdatePickupRequestDto.fromJson(json['updateRequest']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'date': date == null ? '' : date.toUtc().toIso8601String(),
      'status': status,
      'restaurantImage': restaurantImage,
      'restaurantName': restaurantName,
      'updateRequest': updateRequest
    };
  }

  static List<CustomerOldPickupDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CustomerOldPickupDto>()
        : json
        .map((value) => new CustomerOldPickupDto.fromJson(value))
        .toList();
  }

  static Map<String, CustomerOldPickupDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerOldPickupDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new CustomerOldPickupDto.fromJson(value));
    }
    return map;
  }
}
