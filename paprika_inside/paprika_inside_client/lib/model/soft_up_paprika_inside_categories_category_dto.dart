part of swagger.api;

class SoftUpPaprikaInsideCategoriesCategoryDto {
  String id = null;

  String name = null;

  String image = null;

  String thumbnailImage = null;

  bool isActive = null;

  SoftUpPaprikaInsideCategoriesCategoryDto();

  @override
  String toString() {
    return 'SoftUpPaprikaInsideCategoriesCategoryDto[id=$id, name=$name, image=$image, thumbnailImage=$thumbnailImage, isActive=$isActive, ]';
  }

  SoftUpPaprikaInsideCategoriesCategoryDto.fromJson(Map<String, dynamic> json) {
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

  static List<SoftUpPaprikaInsideCategoriesCategoryDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<SoftUpPaprikaInsideCategoriesCategoryDto>()
        : json
            .map((value) =>
                new SoftUpPaprikaInsideCategoriesCategoryDto.fromJson(value))
            .toList();
  }

  static Map<String, SoftUpPaprikaInsideCategoriesCategoryDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SoftUpPaprikaInsideCategoriesCategoryDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] =
          new SoftUpPaprikaInsideCategoriesCategoryDto.fromJson(value));
    }
    return map;
  }
}
