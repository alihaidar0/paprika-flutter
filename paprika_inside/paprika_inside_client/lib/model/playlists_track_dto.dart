part of swagger_inside.api;

class PlaylistsTrackDto {
  int id = null;

  String playlistId = null;

  String title = null;

  int duration = null;

  String artist = null;

  String album = null;

  PlaylistsTrackDto();

  @override
  String toString() {
    return 'PlaylistsTrackDto[id=$id, playlistId=$playlistId, title=$title, duration=$duration, artist=$artist, album=$album, ]';
  }

  PlaylistsTrackDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    playlistId = json['playlistId'];
    title = json['title'];
    duration = json['duration'];
    artist = json['artist'];
    album = json['album'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'playlistId': playlistId,
      'title': title,
      'duration': duration,
      'artist': artist,
      'album': album
    };
  }

  static List<PlaylistsTrackDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PlaylistsTrackDto>()
        : json.map((value) => new PlaylistsTrackDto.fromJson(value)).toList();
  }

  static Map<String, PlaylistsTrackDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PlaylistsTrackDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PlaylistsTrackDto.fromJson(value));
    }
    return map;
  }
}
