part of swagger.api;

class GalleryDto {
  List<GalleryItemDto> galleryItem = [];

  int id = null;

  GalleryDto();

  @override
  String toString() {
    return 'GalleryDto[galleryItem=$galleryItem, id=$id, ]';
  }

  GalleryDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    galleryItem = GalleryItemDto.listFromJson(json['galleryItem']);
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {'galleryItem': galleryItem, 'id': id};
  }

  static List<GalleryDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<GalleryDto>()
        : json.map((value) => new GalleryDto.fromJson(value)).toList();
  }

  static Map<String, GalleryDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, GalleryDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new GalleryDto.fromJson(value));
    }
    return map;
  }
}
