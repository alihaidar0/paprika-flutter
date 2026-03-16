part of swagger.api;

class PagedResultDtoGalleryItemDto {
  int totalCount = null;

  List<GalleryItemDto> items = [];

  PagedResultDtoGalleryItemDto();

  @override
  String toString() {
    return 'PagedResultDtoGalleryItemDto[totalCount=$totalCount, items=$items, ]';
  }

  PagedResultDtoGalleryItemDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    totalCount = json['totalCount'];
    items = GalleryItemDto.listFromJson(json['items']);
  }

  Map<String, dynamic> toJson() {
    return {'totalCount': totalCount, 'items': items};
  }

  static List<PagedResultDtoGalleryItemDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PagedResultDtoGalleryItemDto>()
        : json
            .map((value) => new PagedResultDtoGalleryItemDto.fromJson(value))
            .toList();
  }

  static Map<String, PagedResultDtoGalleryItemDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PagedResultDtoGalleryItemDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PagedResultDtoGalleryItemDto.fromJson(value));
    }
    return map;
  }
}
