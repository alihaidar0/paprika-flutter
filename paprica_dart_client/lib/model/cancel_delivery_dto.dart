part of swagger.api;

class CancelDeliveryDto {
  int id = null;

  String cancelReason = null;

  CancelDeliveryDto();

  @override
  String toString() {
    return 'CancelDeliveryDto[id=$id, cancelReason=$cancelReason, ]';
  }

  CancelDeliveryDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    cancelReason = json['cancelReason'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'cancelReason': cancelReason};
  }

  static List<CancelDeliveryDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CancelDeliveryDto>()
        : json
        .map((value) => new CancelDeliveryDto.fromJson(value))
        .toList();
  }

  static Map<String, CancelDeliveryDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CancelDeliveryDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new CancelDeliveryDto.fromJson(value));
    }
    return map;
  }
}
