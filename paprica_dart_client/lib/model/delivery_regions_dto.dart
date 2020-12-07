part of swagger.api;

class DeliveryRegionsDto {
  List<DeliveryRegionDto> deliveryRegions = [];

  DeliveryRegionsDto();

  @override
  String toString() {
    return 'DeliveryRegionsDto[deliveryRegions=$deliveryRegions,]';
  }

  DeliveryRegionsDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    deliveryRegions = DeliveryRegionDto.listFromJson(json['deliveryRegions']);
  }

  Map<String, dynamic> toJson() {
    return {'deliveryRegions': deliveryRegions,};
  }

  static List<DeliveryRegionsDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<DeliveryRegionsDto>()
        : json.map((value) => new DeliveryRegionsDto.fromJson(value)).toList();
  }

  static Map<String, DeliveryRegionsDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, DeliveryRegionsDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new DeliveryRegionsDto.fromJson(value));
    }
    return map;
  }
}
