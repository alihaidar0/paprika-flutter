part of swagger.api;

class CreateMealDto {
  int categoryId = null;

  String name = null;

  String description = null;

  double price = null;

  String image = null;

  int sequencNumber = null;

  bool isActive = null;

  List<IngredientDto> ingredients = [];

  CreateMealDto();

  @override
  String toString() {
    return 'CreateMealDto[categoryId=$categoryId, name=$name, description=$description, price=$price, image=$image, sequencNumber=$sequencNumber, isActive=$isActive, ingredients=$ingredients, ]';
  }

  CreateMealDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    categoryId = json['categoryId'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
    sequencNumber = json['sequencNumber'];
    isActive = json['isActive'];
    ingredients = IngredientDto.listFromJson(json['ingredients']);
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'sequencNumber': sequencNumber,
      'isActive': isActive,
      'ingredients': ingredients
    };
  }

  static List<CreateMealDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CreateMealDto>()
        : json.map((value) => new CreateMealDto.fromJson(value)).toList();
  }

  static Map<String, CreateMealDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CreateMealDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CreateMealDto.fromJson(value));
    }
    return map;
  }
}
