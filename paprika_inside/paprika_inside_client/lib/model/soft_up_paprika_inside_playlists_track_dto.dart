part of swagger_inside.api;

class SoftUpPaprikaInsidePlaylistsTrackDto {
  int id = null;

  String playlistId = null;

  String title = null;

  int duration = null;

  String artist = null;

  String album = null;

  SoftUpPaprikaInsidePlaylistsTrackDto();

  @override
  String toString() {
    return 'SoftUpPaprikaInsidePlaylistsTrackDto[id=$id, playlistId=$playlistId, title=$title, duration=$duration, artist=$artist, album=$album, ]';
  }

  SoftUpPaprikaInsidePlaylistsTrackDto.fromJson(Map<String, dynamic> json) {
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

  static List<SoftUpPaprikaInsidePlaylistsTrackDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<SoftUpPaprikaInsidePlaylistsTrackDto>()
        : json
            .map((value) =>
                new SoftUpPaprikaInsidePlaylistsTrackDto.fromJson(value))
            .toList();
  }

  static Map<String, SoftUpPaprikaInsidePlaylistsTrackDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SoftUpPaprikaInsidePlaylistsTrackDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new SoftUpPaprikaInsidePlaylistsTrackDto.fromJson(value));
    }
    return map;
  }
}
