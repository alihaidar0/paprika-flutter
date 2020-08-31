part of swagger.api;

class ISettingValue {
  String name = null;

  String value = null;

  ISettingValue();

  @override
  String toString() {
    return 'ISettingValue[name=$name, value=$value, ]';
  }

  ISettingValue.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'value': value};
  }

  static List<ISettingValue> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ISettingValue>()
        : json.map((value) => new ISettingValue.fromJson(value)).toList();
  }

  static Map<String, ISettingValue> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ISettingValue>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ISettingValue.fromJson(value));
    }
    return map;
  }
}
