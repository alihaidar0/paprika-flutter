part of swagger.api;

class CustomerOldReservationDto {
  int id = null;

  int numberOfPeople = null;

  DateTime date = null;

  int status = null;

  String customerAdditionalInfo = null;

  int occasionType = null;

  int restaurantId = null;

  String restaurantImage = null;

  String restaurantName = null;

  UpdateReservationRequestDto updateRequest = null;

  CustomerOldReservationDto();

  @override
  String toString() {
    return 'CustomerOldReservationDto[id=$id, numberOfPeople=$numberOfPeople, date=$date, status=$status, customerAdditionalInfo=$customerAdditionalInfo, occasionType=$occasionType, restaurantId=$restaurantId, restaurantImage=$restaurantImage, restaurantName=$restaurantName, updateRequest=$updateRequest, ]';
  }

  CustomerOldReservationDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    numberOfPeople = json['numberOfPeople'];
    date = json['date'] == null ? null : DateTime.parse(json['date']);
    status = json['status'];
    customerAdditionalInfo = json['customerAdditionalInfo'];
    occasionType = json['occasionType'];
    restaurantId = json['restaurantId'];
    restaurantImage = json['restaurantImage'];
    restaurantName = json['restaurantName'];
    updateRequest =
        new UpdateReservationRequestDto.fromJson(json['updateRequest']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numberOfPeople': numberOfPeople,
      'date': date == null ? '' : date.toUtc().toIso8601String(),
      'status': status,
      'customerAdditionalInfo': customerAdditionalInfo,
      'occasionType': occasionType,
      'restaurantId': restaurantId,
      'restaurantImage': restaurantImage,
      'restaurantName': restaurantName,
      'updateRequest': updateRequest
    };
  }

  static List<CustomerOldReservationDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CustomerOldReservationDto>()
        : json
            .map((value) => new CustomerOldReservationDto.fromJson(value))
            .toList();
  }

  static Map<String, CustomerOldReservationDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerOldReservationDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CustomerOldReservationDto.fromJson(value));
    }
    return map;
  }
}
