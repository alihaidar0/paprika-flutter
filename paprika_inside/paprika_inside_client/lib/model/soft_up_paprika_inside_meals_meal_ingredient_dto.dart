part of swagger.api;

class SoftUpPaprikaInsideMealsMealIngredientDto {
  String ingredientId = null;

  String name = null;

  SoftUpPaprikaInsideMealsMealIngredientDto();

  @override
  String toString() {
    return 'SoftUpPaprikaInsideMealsMealIngredientDto[ingredientId=$ingredientId, name=$name, ]';
  }

  SoftUpPaprikaInsideMealsMealIngredientDto.fromJson(
      Map<String, dynamic> json) {
    if (json == null) return;
    ingredientId = json['ingredientId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {'ingredientId': ingredientId, 'name': name};
  }

  static List<SoftUpPaprikaInsideMealsMealIngredientDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<SoftUpPaprikaInsideMealsMealIngredientDto>()
        : json
            .map((value) =>
                new SoftUpPaprikaInsideMealsMealIngredientDto.fromJson(value))
            .toList();
  }

  static Map<String, SoftUpPaprikaInsideMealsMealIngredientDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SoftUpPaprikaInsideMealsMealIngredientDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] =
          new SoftUpPaprikaInsideMealsMealIngredientDto.fromJson(value));
    }
    return map;
  }
}
