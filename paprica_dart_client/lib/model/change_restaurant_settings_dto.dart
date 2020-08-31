part of swagger.api;

class ChangeRestaurantSettingsDto {
  List<ChangeSettingDto> settings = [];

  ChangeRestaurantSettingsDto();

  @override
  String toString() {
    return 'ChangeRestaurantSettingsDto[settings=$settings, ]';
  }

  ChangeRestaurantSettingsDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    settings = ChangeSettingDto.listFromJson(json['settings']);
  }

  Map<String, dynamic> toJson() {
    return {'settings': settings};
  }

  static List<ChangeRestaurantSettingsDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ChangeRestaurantSettingsDto>()
        : json
            .map((value) => new ChangeRestaurantSettingsDto.fromJson(value))
            .toList();
  }

  static Map<String, ChangeRestaurantSettingsDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ChangeRestaurantSettingsDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ChangeRestaurantSettingsDto.fromJson(value));
    }
    return map;
  }
}
