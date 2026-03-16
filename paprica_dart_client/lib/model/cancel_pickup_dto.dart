part of swagger.api;

class CancelPickupDto {
  int id = null;

  String cancelReason = null;

  CancelPickupDto();

  @override
  String toString() {
    return 'CancelPickupDto[id=$id, cancelReason=$cancelReason, ]';
  }

  CancelPickupDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    cancelReason = json['cancelReason'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'cancelReason': cancelReason};
  }

  static List<CancelPickupDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CancelPickupDto>()
        : json
        .map((value) => new CancelPickupDto.fromJson(value))
        .toList();
  }

  static Map<String, CancelPickupDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CancelPickupDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new CancelPickupDto.fromJson(value));
    }
    return map;
  }
}
