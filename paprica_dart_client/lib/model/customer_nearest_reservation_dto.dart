part of swagger.api;

class CustomerNearestReservationDto {
  int id = null;

  int restaurantId = null;

  int numberOfPeople = null;

  DateTime date = null;

  int status = null;

  String customerAdditionalInfo = null;

  String occasionType = null;

  String restaurantImage = null;

  String restaurantName = null;

  String personName = null;

  String personPhoneNumber = null;

  CustomerNearestReservationDto();

  @override
  String toString() {
    return 'CustomerNearestReservationDto[id=$id, restaurantId=$restaurantId, numberOfPeople=$numberOfPeople, date=$date, status=$status, customerAdditionalInfo=$customerAdditionalInfo, occasionType=$occasionType, restaurantImage=$restaurantImage, restaurantName=$restaurantName,  personName=$personName, personPhoneNumber=$personPhoneNumber]';
  }

  CustomerNearestReservationDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    restaurantId = json['restaurantId'];
    numberOfPeople = json['numberOfPeople'];
    date = json['date'] == null ? null : DateTime.parse(json['date'].toString());
    status = json['status'];
    customerAdditionalInfo = json['customerAdditionalInfo'];
    occasionType = json['occasionType'];
    restaurantImage = json['restaurantImage'];
    restaurantName = json['restaurantName'];
    personName = json['personName'];
    personPhoneNumber = json['personPhoneNumber'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'numberOfPeople': numberOfPeople,
      'date': date == null ? '' : date.toUtc().toIso8601String(),
      'status': status,
      'customerAdditionalInfo': customerAdditionalInfo,
      'occasionType': occasionType,
      'restaurantImage': restaurantImage,
      'restaurantName': restaurantName,
      'personName': personName,
      'personPhoneNumber': personPhoneNumber,
    };
  }

  static List<CustomerNearestReservationDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CustomerNearestReservationDto>()
        : json
        .map((value) => new CustomerNearestReservationDto.fromJson(value))
        .toList();
  }

  static Map<String, CustomerNearestReservationDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerNearestReservationDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new CustomerNearestReservationDto.fromJson(value));
    }
    return map;
  }
}