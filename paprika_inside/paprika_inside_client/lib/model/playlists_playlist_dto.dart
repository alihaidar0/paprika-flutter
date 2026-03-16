part of swagger_inside.api;

class PlaylistsPlaylistDto {
  String id = null;

  String title = null;

  String image = null;

  PlaylistsPlaylistDto();

  @override
  String toString() {
    return 'PlaylistsPlaylistDto[id=$id, title=$title, image=$image, ]';
  }

  PlaylistsPlaylistDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'image': image};
  }

  static List<PlaylistsPlaylistDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PlaylistsPlaylistDto>()
        : json
            .map((value) => new PlaylistsPlaylistDto.fromJson(value))
            .toList();
  }

  static Map<String, PlaylistsPlaylistDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PlaylistsPlaylistDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PlaylistsPlaylistDto.fromJson(value));
    }
    return map;
  }
}
