part of swagger_inside.api;

class CategoriesCategoryDto {
  String id = null;

  String name = null;

  String image = null;

  String thumbnailImage = null;

  bool isActive = null;

  CategoriesCategoryDto();

  @override
  String toString() {
    return 'CategoriesCategoryDto[id=$id, name=$name, image=$image, thumbnailImage=$thumbnailImage, isActive=$isActive, ]';
  }

  CategoriesCategoryDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    image = json['image'];
    thumbnailImage = json['thumbnailImage'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'thumbnailImage': thumbnailImage,
      'isActive': isActive
    };
  }

  static List<CategoriesCategoryDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CategoriesCategoryDto>()
        : json
            .map((value) => new CategoriesCategoryDto.fromJson(value))
            .toList();
  }

  static Map<String, CategoriesCategoryDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CategoriesCategoryDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CategoriesCategoryDto.fromJson(value));
    }
    return map;
  }
}
