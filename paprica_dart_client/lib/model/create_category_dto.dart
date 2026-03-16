part of swagger.api;

class CreateCategoryDto {
  String name = null;

  String image = null;

  bool isActive = null;

  int sequenceNumber = null;

  CreateCategoryDto();

  @override
  String toString() {
    return 'CreateCategoryDto[name=$name, image=$image, isActive=$isActive, sequenceNumber=$sequenceNumber, ]';
  }

  CreateCategoryDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    image = json['image'];
    isActive = json['isActive'];
    sequenceNumber = json['sequenceNumber'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'isActive': isActive,
      'sequenceNumber': sequenceNumber
    };
  }

  static List<CreateCategoryDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CreateCategoryDto>()
        : json.map((value) => new CreateCategoryDto.fromJson(value)).toList();
  }

  static Map<String, CreateCategoryDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CreateCategoryDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CreateCategoryDto.fromJson(value));
    }
    return map;
  }
}
