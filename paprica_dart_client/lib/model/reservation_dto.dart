part of swagger.api;

class ReservationDto {
  int customerId = null;

  int restaurantId = null;

  int numberOfPeople = null;

  DateTime time = null;

  int status = null;

  String customerAdditionalInfo = null;

  String phoneNumber = null;

  int occasionType = null;

  String cancelReason = null;

  String personName = null;

  List<UpdateReservationRequestDto> updateRequests = [];

  int id = null;

  ReservationDto();

  @override
  String toString() {
    return 'ReservationDto[customerId=$customerId, restaurantId=$restaurantId, numberOfPeople=$numberOfPeople, time=$time, status=$status, customerAdditionalInfo=$customerAdditionalInfo, phoneNumber=$phoneNumber, occasionType=$occasionType, cancelReason=$cancelReason, personName=$personName, updateRequests=$updateRequests, id=$id, ]';
  }

  ReservationDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    customerId = json['customerId'];
    restaurantId = json['restaurantId'];
    numberOfPeople = json['numberOfPeople'];
    time = json['time'] == null ? null : DateTime.parse(json['time']);
    status = json['status'];
    customerAdditionalInfo = json['customerAdditionalInfo'];
    phoneNumber = json['phoneNumber'];
    occasionType = json['occasionType'];
    cancelReason = json['cancelReason'];
    personName = json['personName'];
    updateRequests =
        UpdateReservationRequestDto.listFromJson(json['updateRequests']);
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'restaurantId': restaurantId,
      'numberOfPeople': numberOfPeople,
      'time': time == null ? '' : time.toUtc().toIso8601String(),
      'status': status,
      'customerAdditionalInfo': customerAdditionalInfo,
      'phoneNumber': phoneNumber,
      'occasionType': occasionType,
      'cancelReason': cancelReason,
      'personName': personName,
      'updateRequests': updateRequests,
      'id': id
    };
  }

  static List<ReservationDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ReservationDto>()
        : json.map((value) => new ReservationDto.fromJson(value)).toList();
  }

  static Map<String, ReservationDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ReservationDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ReservationDto.fromJson(value));
    }
    return map;
  }
}
