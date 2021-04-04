part of swagger_inside.api;

class SoftUpPaprikaInsidePlaylistsPlaylistDto {
  String id = null;

  String title = null;

  String image = null;

  SoftUpPaprikaInsidePlaylistsPlaylistDto();

  @override
  String toString() {
    return 'SoftUpPaprikaInsidePlaylistsPlaylistDto[id=$id, title=$title, image=$image, ]';
  }

  SoftUpPaprikaInsidePlaylistsPlaylistDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'image': image};
  }

  static List<SoftUpPaprikaInsidePlaylistsPlaylistDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<SoftUpPaprikaInsidePlaylistsPlaylistDto>()
        : json
            .map((value) =>
                new SoftUpPaprikaInsidePlaylistsPlaylistDto.fromJson(value))
            .toList();
  }

  static Map<String, SoftUpPaprikaInsidePlaylistsPlaylistDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SoftUpPaprikaInsidePlaylistsPlaylistDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] =
          new SoftUpPaprikaInsidePlaylistsPlaylistDto.fromJson(value));
    }
    return map;
  }
}
