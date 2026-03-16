part of swagger.api;

class DeliveryRegionDto {
  String name = null;

  int id = null;

  DeliveryRegionDto();

  @override
  String toString() {
    return 'DeliveryRegionDto[name=$name, id=$id, ]';
  }

  DeliveryRegionDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'id': id,};
  }

  static List<DeliveryRegionDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<DeliveryRegionDto>()
        : json.map((value) => new DeliveryRegionDto.fromJson(value)).toList();
  }

  static Map<String, DeliveryRegionDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, DeliveryRegionDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new DeliveryRegionDto.fromJson(value));
    }
    return map;
  }
}
