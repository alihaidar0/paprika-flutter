part of swagger.api;

class CategoryDto {
  String name = null;

  String thumbnailImage = null;

  String image = null;

  int sequenceNumber = null;

  bool isActive = null;

  int id = null;

  CategoryDto();

  @override
  String toString() {
    return 'CategoryDto[name=$name, thumbnailImage=$thumbnailImage, image=$image, sequenceNumber=$sequenceNumber, isActive=$isActive, id=$id, ]';
  }

  CategoryDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    thumbnailImage = json['thumbnailImage'];
    image = json['image'];
    sequenceNumber = json['sequenceNumber'];
    isActive = json['isActive'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'thumbnailImage': thumbnailImage,
      'image': image,
      'sequenceNumber': sequenceNumber,
      'isActive': isActive,
      'id': id
    };
  }

  static List<CategoryDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CategoryDto>()
        : json.map((value) => new CategoryDto.fromJson(value)).toList();
  }

  static Map<String, CategoryDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CategoryDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CategoryDto.fromJson(value));
    }
    return map;
  }
}
