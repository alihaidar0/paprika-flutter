part of swagger.api;

class GalleryItemDto {
  
  String image = null;
  

  String thumbnailImage = null;
  

  int type = null;
  

  String description = null;
  

  String title = null;
  

  int id = null;
  
  GalleryItemDto();

  @override
  String toString() {
    return 'GalleryItemDto[image=$image, thumbnailImage=$thumbnailImage, type=$type, description=$description, title=$title, id=$id, ]';
  }

  GalleryItemDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    image =
        json['image']
    ;
    thumbnailImage =
        json['thumbnailImage']
    ;
    type =
        json['type']
    ;
    description =
        json['description']
    ;
    title =
        json['title']
    ;
    id =
        json['id']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'thumbnailImage': thumbnailImage,
      'type': type,
      'description': description,
      'title': title,
      'id': id
     };
  }

  static List<GalleryItemDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<GalleryItemDto>() : json.map((value) => new GalleryItemDto.fromJson(value)).toList();
  }

  static Map<String, GalleryItemDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, GalleryItemDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new GalleryItemDto.fromJson(value));
    }
    return map;
  }
}

