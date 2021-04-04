part of swagger.api;

class SoftUpPaprikaInsidePlaylistsTrackRequestDto {
  String customerTableId = null;

  int trackId = null;

  SoftUpPaprikaInsidePlaylistsTrackRequestDto();

  @override
  String toString() {
    return 'SoftUpPaprikaInsidePlaylistsTrackRequestDto[customerTableId=$customerTableId, trackId=$trackId, ]';
  }

  SoftUpPaprikaInsidePlaylistsTrackRequestDto.fromJson(
      Map<String, dynamic> json) {
    if (json == null) return;
    customerTableId = json['customerTableId'];
    trackId = json['trackId'];
  }

  Map<String, dynamic> toJson() {
    return {'customerTableId': customerTableId, 'trackId': trackId};
  }

  static List<SoftUpPaprikaInsidePlaylistsTrackRequestDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<SoftUpPaprikaInsidePlaylistsTrackRequestDto>()
        : json
            .map((value) =>
                new SoftUpPaprikaInsidePlaylistsTrackRequestDto.fromJson(value))
            .toList();
  }

  static Map<String, SoftUpPaprikaInsidePlaylistsTrackRequestDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SoftUpPaprikaInsidePlaylistsTrackRequestDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] =
          new SoftUpPaprikaInsidePlaylistsTrackRequestDto.fromJson(value));
    }
    return map;
  }
}
