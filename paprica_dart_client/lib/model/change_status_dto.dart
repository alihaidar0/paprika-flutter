part of swagger.api;

class ChangeStatusDto {
  int restaurantId = null;

  int status = null;

  ChangeStatusDto();

  @override
  String toString() {
    return 'ChangeStatusDto[restaurantId=$restaurantId, status=$status, ]';
  }

  ChangeStatusDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    restaurantId = json['restaurantId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {'restaurantId': restaurantId, 'status': status};
  }

  static List<ChangeStatusDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ChangeStatusDto>()
        : json.map((value) => new ChangeStatusDto.fromJson(value)).toList();
  }

  static Map<String, ChangeStatusDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ChangeStatusDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ChangeStatusDto.fromJson(value));
    }
    return map;
  }
}
