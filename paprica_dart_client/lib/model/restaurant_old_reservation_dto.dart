part of swagger.api;

class RestaurantOldReservationDto {
  int numberOfPeople = null;

  DateTime date = null;

  int status = null;

  String customerAdditionalInfo = null;

  int occasionType = null;

  double restaurantLongitude = null;

  double restaurantLatitude = null;

  String customerName = null;

  String customerPhoneNumber = null;

  UpdateReservationRequestDto updateRequest = null;

  RestaurantOldReservationDto();

  @override
  String toString() {
    return 'RestaurantOldReservationDto[numberOfPeople=$numberOfPeople, date=$date, status=$status, customerAdditionalInfo=$customerAdditionalInfo, occasionType=$occasionType, restaurantLongitude=$restaurantLongitude, restaurantLatitude=$restaurantLatitude, customerName=$customerName, customerPhoneNumber=$customerPhoneNumber, updateRequest=$updateRequest, ]';
  }

  RestaurantOldReservationDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    numberOfPeople = json['numberOfPeople'];
    date = json['date'] == null ? null : DateTime.parse(json['date']);
    status = json['status'];
    customerAdditionalInfo = json['customerAdditionalInfo'];
    occasionType = json['occasionType'];
    restaurantLongitude = json['restaurantLongitude'];
    restaurantLatitude = json['restaurantLatitude'];
    customerName = json['customerName'];
    customerPhoneNumber = json['customerPhoneNumber'];
    updateRequest =
        new UpdateReservationRequestDto.fromJson(json['updateRequest']);
  }

  Map<String, dynamic> toJson() {
    return {
      'numberOfPeople': numberOfPeople,
      'date': date == null ? '' : date.toUtc().toIso8601String(),
      'status': status,
      'customerAdditionalInfo': customerAdditionalInfo,
      'occasionType': occasionType,
      'restaurantLongitude': restaurantLongitude,
      'restaurantLatitude': restaurantLatitude,
      'customerName': customerName,
      'customerPhoneNumber': customerPhoneNumber,
      'updateRequest': updateRequest
    };
  }

  static List<RestaurantOldReservationDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<RestaurantOldReservationDto>()
        : json
            .map((value) => new RestaurantOldReservationDto.fromJson(value))
            .toList();
  }

  static Map<String, RestaurantOldReservationDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RestaurantOldReservationDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new RestaurantOldReservationDto.fromJson(value));
    }
    return map;
  }
}
