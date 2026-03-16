part of swagger.api;

class CreateGalleryDto {
  List<CreateGalleryItemDto> galleryItem = [];

  CreateGalleryDto();

  @override
  String toString() {
    return 'CreateGalleryDto[galleryItem=$galleryItem, ]';
  }

  CreateGalleryDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    galleryItem = CreateGalleryItemDto.listFromJson(json['galleryItem']);
  }

  Map<String, dynamic> toJson() {
    return {'galleryItem': galleryItem};
  }

  static List<CreateGalleryDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CreateGalleryDto>()
        : json.map((value) => new CreateGalleryDto.fromJson(value)).toList();
  }

  static Map<String, CreateGalleryDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CreateGalleryDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CreateGalleryDto.fromJson(value));
    }
    return map;
  }
}
