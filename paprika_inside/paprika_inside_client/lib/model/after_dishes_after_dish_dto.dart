part of swagger_inside.api;

class AfterDishesAfterDishDto {
  String id = null;

  String name = null;

  AfterDishesAfterDishDto();

  @override
  String toString() {
    return 'AfterDishesAfterDishDto[id=$id, name=$name, ]';
  }

  AfterDishesAfterDishDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  static List<AfterDishesAfterDishDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<AfterDishesAfterDishDto>()
        : json
            .map((value) => new AfterDishesAfterDishDto.fromJson(value))
            .toList();
  }

  static Map<String, AfterDishesAfterDishDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AfterDishesAfterDishDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AfterDishesAfterDishDto.fromJson(value));
    }
    return map;
  }
}
