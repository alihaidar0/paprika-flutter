part of swagger_inside.api;

class PlaylistsTrackRequestDto {
  String customerTableId = null;

  int trackId = null;

  PlaylistsTrackRequestDto();

  @override
  String toString() {
    return 'PlaylistsTrackRequestDto[customerTableId=$customerTableId, trackId=$trackId, ]';
  }

  PlaylistsTrackRequestDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    customerTableId = json['customerTableId'];
    trackId = json['trackId'];
  }

  Map<String, dynamic> toJson() {
    return {'customerTableId': customerTableId, 'trackId': trackId};
  }

  static List<PlaylistsTrackRequestDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PlaylistsTrackRequestDto>()
        : json
            .map((value) => new PlaylistsTrackRequestDto.fromJson(value))
            .toList();
  }

  static Map<String, PlaylistsTrackRequestDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PlaylistsTrackRequestDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PlaylistsTrackRequestDto.fromJson(value));
    }
    return map;
  }
}
