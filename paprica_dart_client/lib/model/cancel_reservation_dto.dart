part of swagger.api;

class CancelReservationDto {
  int id = null;

  String cancelReason = null;

  CancelReservationDto();

  @override
  String toString() {
    return 'CancelReservationDto[id=$id, cancelReason=$cancelReason, ]';
  }

  CancelReservationDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    cancelReason = json['cancelReason'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'cancelReason': cancelReason};
  }

  static List<CancelReservationDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CancelReservationDto>()
        : json
            .map((value) => new CancelReservationDto.fromJson(value))
            .toList();
  }

  static Map<String, CancelReservationDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CancelReservationDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CancelReservationDto.fromJson(value));
    }
    return map;
  }
}
