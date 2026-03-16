part of swagger_inside.api;

class MealsMealDto {
  String id = null;

  String categoryId = null;

  String pointOfServiceId = null;

  String name = null;

  String description = null;

  double price = null;

  String image = null;

  String thumbnailImage = null;

  bool isActive = null;

  List<MealsMealVariantDto> mealVariants = [];

  List<MealsMealIngredientDto> mealIngredients = [];

  MealsMealDto();

  @override
  String toString() {
    return 'MealsMealDto[id=$id, categoryId=$categoryId, pointOfServiceId=$pointOfServiceId, name=$name, description=$description, price=$price, image=$image, thumbnailImage=$thumbnailImage, isActive=$isActive, mealVariants=$mealVariants, mealIngredients=$mealIngredients, ]';
  }

  MealsMealDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    categoryId = json['categoryId'];
    pointOfServiceId = json['pointOfServiceId'];
    name = json['name'];
    description = json['description'];
    price = json['price'] == null ? null : json['price'].toDouble();
    image = json['image'];
    thumbnailImage = json['thumbnailImage'];
    isActive = json['isActive'];
    mealVariants = MealsMealVariantDto.listFromJson(json['mealVariants']);
    mealIngredients =
        MealsMealIngredientDto.listFromJson(json['mealIngredients']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'pointOfServiceId': pointOfServiceId,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'thumbnailImage': thumbnailImage,
      'isActive': isActive,
      'mealVariants': mealVariants,
      'mealIngredients': mealIngredients
    };
  }

  static List<MealsMealDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<MealsMealDto>()
        : json.map((value) => new MealsMealDto.fromJson(value)).toList();
  }

  static Map<String, MealsMealDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MealsMealDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new MealsMealDto.fromJson(value));
    }
    return map;
  }
}
