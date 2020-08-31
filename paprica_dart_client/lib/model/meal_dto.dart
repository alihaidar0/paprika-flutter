part of swagger.api;

class MealDto {
  String name = null;

  String description = null;

  double price = null;

  String image = null;

  String thumbnailImage = null;

  double mealRate = null;

  int sequenceNumber = null;

  bool isActive = null;

  List<IngredientDto> ingredients = [];

  double oldUserRate = null;

  int id = null;

  MealDto();

  @override
  String toString() {
    return 'MealDto[name=$name, description=$description, price=$price, image=$image, thumbnailImage=$thumbnailImage, mealRate=$mealRate, sequenceNumber=$sequenceNumber, isActive=$isActive, ingredients=$ingredients,oldUserRate=$oldUserRate id=$id, ]';
  }

  MealDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
    thumbnailImage = json['thumbnailImage'];
    mealRate = json['mealRate'];
    sequenceNumber = json['sequenceNumber'];
    isActive = json['isActive'];
    ingredients = IngredientDto.listFromJson(json['ingredients']);
    oldUserRate = json['oldUserRate'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'thumbnailImage': thumbnailImage,
      'mealRate': mealRate,
      'sequenceNumber': sequenceNumber,
      'isActive': isActive,
      'ingredients': ingredients,
      'oldUserRate': oldUserRate,
      'id': id
    };
  }

  static List<MealDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<MealDto>()
        : json.map((value) => new MealDto.fromJson(value)).toList();
  }

  static Map<String, MealDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MealDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new MealDto.fromJson(value));
    }
    return map;
  }
}
