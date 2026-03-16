part of swagger.api;

class UpdateReviewStatusDto {
  int id = null;

  int status = null;
  //enum statusEnum {  1,  2,  3,  };
  UpdateReviewStatusDto();

  @override
  String toString() {
    return 'UpdateReviewStatusDto[id=$id, status=$status, ]';
  }

  UpdateReviewStatusDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'status': status};
  }

  static List<UpdateReviewStatusDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UpdateReviewStatusDto>()
        : json
            .map((value) => new UpdateReviewStatusDto.fromJson(value))
            .toList();
  }

  static Map<String, UpdateReviewStatusDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdateReviewStatusDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UpdateReviewStatusDto.fromJson(value));
    }
    return map;
  }
}
