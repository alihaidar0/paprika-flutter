part of swagger_inside.api;

class MealsMealIngredientDto {
  String ingredientId = null;

  String name = null;

  MealsMealIngredientDto();

  @override
  String toString() {
    return 'MealsMealIngredientDto[ingredientId=$ingredientId, name=$name, ]';
  }

  MealsMealIngredientDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    ingredientId = json['ingredientId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {'ingredientId': ingredientId, 'name': name};
  }

  static List<MealsMealIngredientDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<MealsMealIngredientDto>()
        : json
            .map((value) => new MealsMealIngredientDto.fromJson(value))
            .toList();
  }

  static Map<String, MealsMealIngredientDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MealsMealIngredientDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new MealsMealIngredientDto.fromJson(value));
    }
    return map;
  }
}
