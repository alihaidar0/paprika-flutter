part of swagger.api;

class ManagerOfferDto {
  bool isActive = null;

  String image = null;

  String description = null;

  int id = null;

  ManagerOfferDto();

  @override
  String toString() {
    return 'ManagerOfferDto[isActive=$isActive, image=$image, description=$description, id=$id, ]';
  }

  ManagerOfferDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    isActive = json['isActive'];
    image = json['image'];
    description = json['description'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'isActive': isActive,
      'image': image,
      'description': description,
      'id': id
    };
  }

  static List<ManagerOfferDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ManagerOfferDto>()
        : json.map((value) => new ManagerOfferDto.fromJson(value)).toList();
  }

  static Map<String, ManagerOfferDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ManagerOfferDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ManagerOfferDto.fromJson(value));
    }
    return map;
  }
}
