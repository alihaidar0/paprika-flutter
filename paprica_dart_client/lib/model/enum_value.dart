part of swagger.api;

class EnumValue {
  String name = null;

  int value = null;

  EnumValue();

  @override
  String toString() {
    return 'EnumValue[name=$name, value=$value, ]';
  }

  EnumValue.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'value': value};
  }

  static List<EnumValue> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<EnumValue>()
        : json.map((value) => new EnumValue.fromJson(value)).toList();
  }

  static Map<String, EnumValue> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, EnumValue>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new EnumValue.fromJson(value));
    }
    return map;
  }
}
