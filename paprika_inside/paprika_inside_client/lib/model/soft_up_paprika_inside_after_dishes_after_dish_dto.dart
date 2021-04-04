part of swagger_inside.api;

class SoftUpPaprikaInsideAfterDishesAfterDishDto {
  String id = null;

  String name = null;

  SoftUpPaprikaInsideAfterDishesAfterDishDto();

  @override
  String toString() {
    return 'SoftUpPaprikaInsideAfterDishesAfterDishDto[id=$id, name=$name, ]';
  }

  SoftUpPaprikaInsideAfterDishesAfterDishDto.fromJson(
      Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  static List<SoftUpPaprikaInsideAfterDishesAfterDishDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<SoftUpPaprikaInsideAfterDishesAfterDishDto>()
        : json
            .map((value) =>
                new SoftUpPaprikaInsideAfterDishesAfterDishDto.fromJson(value))
            .toList();
  }

  static Map<String, SoftUpPaprikaInsideAfterDishesAfterDishDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SoftUpPaprikaInsideAfterDishesAfterDishDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] =
          new SoftUpPaprikaInsideAfterDishesAfterDishDto.fromJson(value));
    }
    return map;
  }
}
