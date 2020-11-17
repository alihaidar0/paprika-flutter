part of swagger.api;

class CustomerUpcomingReservationDto {
  int maxPeopleAllowed = null;

  String restaurantCoverImage = null;

  double restaurantLongitude = null;

  double restaurantLatitude = null;

  String restaurantPhoneNumber = null;

  String personName = null;

  String personPhoneNumber = null;

  int id = null;

  int numberOfPeople = null;

  DateTime date = null;

  int status = null;

  String customerAdditionalInfo = null;

  String occasionType = null;

  int restaurantId = null;

  String restaurantImage = null;

  String restaurantName = null;

  UpdateReservationRequestDto updateRequest = null;

  CustomerUpcomingReservationDto();

  @override
  String toString() {
    return 'CustomerUpcomingReservationDto[restaurantCoverImage=$restaurantCoverImage, restaurantLongitude=$restaurantLongitude, restaurantLatitude=$restaurantLatitude, restaurantPhoneNumber=$restaurantPhoneNumber, personName=$personName, personPhoneNumber=$personPhoneNumber, id=$id, numberOfPeople=$numberOfPeople, date=$date, status=$status, customerAdditionalInfo=$customerAdditionalInfo, occasionType=$occasionType, restaurantId=$restaurantId, restaurantImage=$restaurantImage, restaurantName=$restaurantName, updateRequest=$updateRequest,maxPeopleAllowed=$maxPeopleAllowed ]';
  }

  CustomerUpcomingReservationDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    maxPeopleAllowed = json['maxPeopleAllowed'];
    restaurantCoverImage = json['restaurantCoverImage'];
    restaurantLongitude = json['restaurantLongitude'];
    restaurantLatitude = json['restaurantLatitude'];
    restaurantPhoneNumber = json['restaurantPhoneNumber'];
    personName = json['personName'];
    personPhoneNumber = json['personPhoneNumber'];
    id = json['id'];
    numberOfPeople = json['numberOfPeople'];
    date =
        json['date'] == null ? null : DateTime.parse(json['date'].toString());
    status = json['status'];
    customerAdditionalInfo = json['customerAdditionalInfo'];
    occasionType = json['occasionType'];
    restaurantId = json['restaurantId'];
    restaurantImage = json['restaurantImage'];
    restaurantName = json['restaurantName'];
    updateRequest = json['updateRequest'] == null
        ? null
        : UpdateReservationRequestDto.fromJson(json['updateRequest']);
  }

  Map<String, dynamic> toJson() {
    return {
      'maxPeopleAllowed': maxPeopleAllowed,
      'restaurantCoverImage': restaurantCoverImage,
      'restaurantLongitude': restaurantLongitude,
      'restaurantLatitude': restaurantLatitude,
      'restaurantPhoneNumber': restaurantPhoneNumber,
      'personName': personName,
      'personPhoneNumber': personPhoneNumber,
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

  static List<CustomerUpcomingReservationDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CustomerUpcomingReservationDto>()
        : json
            .map((value) => new CustomerUpcomingReservationDto.fromJson(value))
            .toList();
  }

  static Map<String, CustomerUpcomingReservationDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerUpcomingReservationDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CustomerUpcomingReservationDto.fromJson(value));
    }
    return map;
  }
}
