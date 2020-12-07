part of swagger.api;

class CustomerOldDeliveryDto {
  int id = null;

  int restaurantId = null;

  int status = null;

  String restaurantImage = null;

  String restaurantName = null;

  UpdateDeliveryRequestDto updateRequest = null;

  CustomerOldDeliveryDto();

  @override
  String toString() {
    return 'CustomerOldDeliveryDto[id=$id, restaurantId=$restaurantId, status=$status, restaurantImage=$restaurantImage, restaurantName=$restaurantName, updateRequest=$updateRequest, ]';
  }

  CustomerOldDeliveryDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    restaurantId = json['restaurantId'];
    status = json['status'];
    restaurantImage = json['restaurantImage'];
    restaurantName = json['restaurantName'];
    updateRequest =
    new UpdateDeliveryRequestDto.fromJson(json['updateRequest']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'status': status,
      'restaurantImage': restaurantImage,
      'restaurantName': restaurantName,
      'updateRequest': updateRequest
    };
  }

  static List<CustomerOldDeliveryDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CustomerOldDeliveryDto>()
        : json
        .map((value) => new CustomerOldDeliveryDto.fromJson(value))
        .toList();
  }

  static Map<String, CustomerOldDeliveryDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerOldDeliveryDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new CustomerOldDeliveryDto.fromJson(value));
    }
    return map;
  }
}
