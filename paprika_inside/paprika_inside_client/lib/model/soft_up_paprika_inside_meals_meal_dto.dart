part of swagger_inside.api;

class SoftUpPaprikaInsideMealsMealDto {
  String id = null;

  String categoryId = null;

  String pointOfServiceId = null;

  String name = null;

  String description = null;

  double price = null;

  String image = null;

  String thumbnailImage = null;

  bool isActive = null;

  List<SoftUpPaprikaInsideMealsMealVariantDto> mealVariants = [];

  List<SoftUpPaprikaInsideMealsMealIngredientDto> mealIngredients = [];

  SoftUpPaprikaInsideMealsMealDto();

  @override
  String toString() {
    return 'SoftUpPaprikaInsideMealsMealDto[id=$id, categoryId=$categoryId, pointOfServiceId=$pointOfServiceId, name=$name, description=$description, price=$price, image=$image, thumbnailImage=$thumbnailImage, isActive=$isActive, mealVariants=$mealVariants, mealIngredients=$mealIngredients, ]';
  }

  SoftUpPaprikaInsideMealsMealDto.fromJson(Map<String, dynamic> json) {
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
    mealVariants = SoftUpPaprikaInsideMealsMealVariantDto.listFromJson(
        json['mealVariants']);
    mealIngredients = SoftUpPaprikaInsideMealsMealIngredientDto.listFromJson(
        json['mealIngredients']);
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

  static List<SoftUpPaprikaInsideMealsMealDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<SoftUpPaprikaInsideMealsMealDto>()
        : json
            .map((value) => new SoftUpPaprikaInsideMealsMealDto.fromJson(value))
            .toList();
  }

  static Map<String, SoftUpPaprikaInsideMealsMealDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SoftUpPaprikaInsideMealsMealDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new SoftUpPaprikaInsideMealsMealDto.fromJson(value));
    }
    return map;
  }
}
