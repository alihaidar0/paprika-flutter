part of swagger.api;

class EntityDtoInt64 {
  int id = null;

  EntityDtoInt64(int idInt) {
    id = idInt;
  }

  @override
  String toString() {
    return 'EntityDtoInt64[id=$id, ]';
  }

  EntityDtoInt64.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }

  static List<EntityDtoInt64> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<EntityDtoInt64>()
        : json.map((value) => new EntityDtoInt64.fromJson(value)).toList();
  }

  static Map<String, EntityDtoInt64> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, EntityDtoInt64>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new EntityDtoInt64.fromJson(value));
    }
    return map;
  }
}
