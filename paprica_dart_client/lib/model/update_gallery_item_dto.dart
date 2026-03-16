part of swagger.api;

class UpdateGalleryItemDto {
  String image = null;

  int type = null;

  String description = null;

  String title = null;

  int id = null;

  UpdateGalleryItemDto();

  @override
  String toString() {
    return 'UpdateGalleryItemDto[image=$image, type=$type, description=$description, title=$title, id=$id, ]';
  }

  UpdateGalleryItemDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    image = json['image'];
    type = json['type'];
    description = json['description'];
    title = json['title'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'type': type,
      'description': description,
      'title': title,
      'id': id
    };
  }

  static List<UpdateGalleryItemDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UpdateGalleryItemDto>()
        : json
            .map((value) => new UpdateGalleryItemDto.fromJson(value))
            .toList();
  }

  static Map<String, UpdateGalleryItemDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdateGalleryItemDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UpdateGalleryItemDto.fromJson(value));
    }
    return map;
  }
}
