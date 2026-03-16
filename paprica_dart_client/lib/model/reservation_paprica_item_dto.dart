part of swagger.api;

class ReservationPapricaItemDto {
  int restaurantId = null;

  String title = null;
  int numberOfPeople = null;

  bool isUpcoming = false;
  DateTime time = null;

  int status = null;

  bool hasPendingUpdate = null;

  String restaurantPhoneNumber = null;

  String restaurantName = null;
  String restaurantLogo = null;

  int id = null;

  ReservationPapricaItemDto();

  @override
  String toString() {
    return 'ReservationPapricaItemDto[restaurantId=$restaurantId, numberOfPeople=$numberOfPeople, time=$time, status=$status, hasPendingUpdate=$hasPendingUpdate, restaurantPhoneNumber=$restaurantPhoneNumber,  restaurantName=$restaurantName, restaurantLogo=$restaurantLogo, id=$id, ]';
  }

  ReservationPapricaItemDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    restaurantId = json['restaurantId'];
    numberOfPeople = json['numberOfPeople'];
    time = json['time'] == null ? null : DateTime.parse(json['time']);
    status = json['status'];
    restaurantLogo = json['restaurantLogo'];
    hasPendingUpdate = json['hasPendingUpdate'];
    restaurantPhoneNumber = json['restaurantPhoneNumber'];
    restaurantName = json['restaurantName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'restaurantId': restaurantId,
      'numberOfPeople': numberOfPeople,
      'time': time == null ? '' : time.toUtc().toIso8601String(),
      'status': status,
      'restaurantLogo': restaurantLogo,
      'hasPendingUpdate': hasPendingUpdate,
      'restaurantPhoneNumber': restaurantPhoneNumber,
      'restaurantName': restaurantName,
      'id': id
    };
  }

  static List<ReservationPapricaItemDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ReservationPapricaItemDto>()
        : json
            .map((value) => new ReservationPapricaItemDto.fromJson(value))
            .toList();
  }

  static Map<String, ReservationPapricaItemDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ReservationPapricaItemDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ReservationPapricaItemDto.fromJson(value));
    }
    return map;
  }
}
