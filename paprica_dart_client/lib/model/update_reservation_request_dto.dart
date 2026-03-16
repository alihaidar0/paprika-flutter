part of swagger.api;

class UpdateReservationRequestDto {
  int reservationId = null;

  DateTime time = null;

  String customerAdditionalInfo = null;

  String phoneNumber = null;

  int occasionType = null;

  String personName = null;

  int numberOfPeople = null;

  UpdateReservationRequestDto();

  @override
  String toString() {
    return 'UpdateReservationRequestDto[reservationId=$reservationId, time=$time, customerAdditionalInfo=$customerAdditionalInfo, phoneNumber=$phoneNumber, occasionType=$occasionType, personName=$personName, numberOfPeople=$numberOfPeople, ]';
  }

  UpdateReservationRequestDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    reservationId = json['reservationId'];
    time =
        json['time'] == null ? null : DateTime.parse(json['time'].toString());
    customerAdditionalInfo = json['customerAdditionalInfo'];
    phoneNumber = json['phoneNumber'];
    occasionType = json['occasionType'];
    personName = json['personName'];
    numberOfPeople = json['numberOfPeople'];
  }

  Map<String, dynamic> toJson() {
    return {
      'reservationId': reservationId,
      'time': time == null ? '' : time.toUtc().toIso8601String(),
      'customerAdditionalInfo': customerAdditionalInfo,
      'phoneNumber': phoneNumber,
      'occasionType': occasionType,
      'personName': personName,
      'numberOfPeople': numberOfPeople
    };
  }

  static List<UpdateReservationRequestDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UpdateReservationRequestDto>()
        : json
            .map((value) => new UpdateReservationRequestDto.fromJson(value))
            .toList();
  }

  static Map<String, UpdateReservationRequestDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdateReservationRequestDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UpdateReservationRequestDto.fromJson(value));
    }
    return map;
  }
}
