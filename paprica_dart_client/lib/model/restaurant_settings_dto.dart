part of swagger.api;

class RestaurantSettingsDto {
  int maxPeopleAllowed = null;

  List<ServiceDto> services = [];

  RestaurantSettingsDto();

  @override
  String toString() {
    return 'RestaurantSettingsDto[services=$services, maxPeopleAllowed=$maxPeopleAllowed ]';
  }

  RestaurantSettingsDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    services = ServiceDto.listFromJson(json['services']);
    maxPeopleAllowed = json['maxPeopleAllowed'];
  }

  Map<String, dynamic> toJson() {
    return {'services': services, 'maxPeopleAllowed': maxPeopleAllowed};
  }

  static List<RestaurantSettingsDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<RestaurantSettingsDto>()
        : json
            .map((value) => new RestaurantSettingsDto.fromJson(value))
            .toList();
  }

  static Map<String, RestaurantSettingsDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RestaurantSettingsDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new RestaurantSettingsDto.fromJson(value));
    }
    return map;
  }
}
