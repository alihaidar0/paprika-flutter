part of swagger.api;

class UpdateOfferDto {
  bool isActive = null;

  String image = null;

  String description = null;

  int id = null;

  UpdateOfferDto();

  @override
  String toString() {
    return 'UpdateOfferDto[isActive=$isActive, image=$image, description=$description, id=$id, ]';
  }

  UpdateOfferDto.fromJson(Map<String, dynamic> json) {
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

  static List<UpdateOfferDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UpdateOfferDto>()
        : json.map((value) => new UpdateOfferDto.fromJson(value)).toList();
  }

  static Map<String, UpdateOfferDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdateOfferDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UpdateOfferDto.fromJson(value));
    }
    return map;
  }
}
