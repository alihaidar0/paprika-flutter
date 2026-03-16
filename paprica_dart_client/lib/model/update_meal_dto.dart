part of swagger.api;

class UpdateMealDto {
  int id = null;

  String name = null;

  String description = null;

  double price = null;

  String image = null;

  int sequencNumber = null;

  bool isActive = null;

  List<IngredientDto> ingredients = [];

  UpdateMealDto();

  @override
  String toString() {
    return 'UpdateMealDto[id=$id, name=$name, description=$description, price=$price, image=$image, sequencNumber=$sequencNumber, isActive=$isActive, ingredients=$ingredients, ]';
  }

  UpdateMealDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
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
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'sequencNumber': sequencNumber,
      'isActive': isActive,
      'ingredients': ingredients
    };
  }

  static List<UpdateMealDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UpdateMealDto>()
        : json.map((value) => new UpdateMealDto.fromJson(value)).toList();
  }

  static Map<String, UpdateMealDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdateMealDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UpdateMealDto.fromJson(value));
    }
    return map;
  }
}
