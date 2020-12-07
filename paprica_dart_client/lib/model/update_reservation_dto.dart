part of swagger.api;

class UpdateReservationDto {
  int restaurantId = null;

  int numberOfPeople = null;
  // range from 1 to 25//

  DateTime time = null;

  DateTime date = null;

  String customerAdditionalInfo = null;

  String phoneNumber = null;

  int occasionType = null;

  String personName = null;

  int id = null;

  UpdateReservationDto();

  @override
  String toString() {
    return 'UpdateReservationDto[restaurantId=$restaurantId, numberOfPeople=$numberOfPeople, time=$time, date=$date, customerAdditionalInfo=$customerAdditionalInfo, phoneNumber=$phoneNumber, occasionType=$occasionType, personName=$personName, id=$id, ]';
  }

  UpdateReservationDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    restaurantId = json['restaurantId'];
    numberOfPeople = json['numberOfPeople'];
    time = json['time'] == null ? null : DateTime.parse(json['time']);
    date = json['date'] == null ? null : DateTime.parse(json['date']);
    customerAdditionalInfo = json['customerAdditionalInfo'];
    phoneNumber = json['phoneNumber'];
    occasionType = json['occasionType'];
    personName = json['personName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'restaurantId': restaurantId,
      'numberOfPeople': numberOfPeople,
      'time': time == null ? '' : time.toUtc().toIso8601String(),
      'date': date == null ? '' : date.toUtc().toIso8601String(),
      'customerAdditionalInfo': customerAdditionalInfo,
      'phoneNumber': phoneNumber,
      'occasionType': occasionType,
      'personName': personName,
      'id': id
    };
  }

  static List<UpdateReservationDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UpdateReservationDto>()
        : json
            .map((value) => new UpdateReservationDto.fromJson(value))
            .toList();
  }

  static Map<String, UpdateReservationDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdateReservationDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UpdateReservationDto.fromJson(value));
    }
    return map;
  }
}
