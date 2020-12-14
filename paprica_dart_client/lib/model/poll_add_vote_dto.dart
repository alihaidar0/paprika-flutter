part of swagger.api;

class PollAddVoteDto {
  int pollId = null;

  int restaurantId = null;

  PollAddVoteDto();

  @override
  String toString() {
    return 'PollAddVoteDto[pollId=$pollId, restaurantId=$restaurantId, ]';
  }

  PollAddVoteDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    pollId = json['pollId'];
    restaurantId = json['restaurantId'];
  }

  Map<String, dynamic> toJson() {
    return {'pollId': pollId, 'restaurantId': restaurantId};
  }

  static List<PollAddVoteDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PollAddVoteDto>()
        : json
        .map((value) => new PollAddVoteDto.fromJson(value))
        .toList();
  }

  static Map<String, PollAddVoteDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PollAddVoteDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new PollAddVoteDto.fromJson(value));
    }
    return map;
  }
}
