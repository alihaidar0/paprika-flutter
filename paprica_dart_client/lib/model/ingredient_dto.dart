part of swagger.api;

class IngredientDto {
  String name = null;

  int id = null;

  IngredientDto();

  @override
  String toString() {
    return 'IngredientDto[name=$name, id=$id, ]';
  }

  IngredientDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'id': id};
  }

  static List<IngredientDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<IngredientDto>()
        : json.map((value) => new IngredientDto.fromJson(value)).toList();
  }

  static Map<String, IngredientDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, IngredientDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new IngredientDto.fromJson(value));
    }
    return map;
  }
}
