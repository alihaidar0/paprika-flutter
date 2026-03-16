part of swagger.api;

class CreateGalleryItemDto {
  String image = null;

  int type = null;

  String description = null;

  String title = null;

  CreateGalleryItemDto();

  @override
  String toString() {
    return 'CreateGalleryItemDto[image=$image, type=$type, description=$description, title=$title, ]';
  }

  CreateGalleryItemDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    image = json['image'];
    type = json['type'];
    description = json['description'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'type': type,
      'description': description,
      'title': title
    };
  }

  static List<CreateGalleryItemDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CreateGalleryItemDto>()
        : json
            .map((value) => new CreateGalleryItemDto.fromJson(value))
            .toList();
  }

  static Map<String, CreateGalleryItemDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CreateGalleryItemDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CreateGalleryItemDto.fromJson(value));
    }
    return map;
  }
}
