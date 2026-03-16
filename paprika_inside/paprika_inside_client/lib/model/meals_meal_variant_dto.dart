part of swagger_inside.api;

class MealsMealVariantDto {
  int id = null;

  String name = null;

  double margin = null;

  bool isActive = null;

  MealsMealVariantDto();

  @override
  String toString() {
    return 'MealsMealVariantDto[id=$id, name=$name, margin=$margin, isActive=$isActive, ]';
  }

  MealsMealVariantDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    margin = json['margin'] == null ? null : json['margin'].toDouble();
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'margin': margin, 'isActive': isActive};
  }

  static List<MealsMealVariantDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<MealsMealVariantDto>()
        : json.map((value) => new MealsMealVariantDto.fromJson(value)).toList();
  }

  static Map<String, MealsMealVariantDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MealsMealVariantDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new MealsMealVariantDto.fromJson(value));
    }
    return map;
  }
}
