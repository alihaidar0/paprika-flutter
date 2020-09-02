part of swagger.api;

class UpdateStatusDto {
  int id = null;

  bool isActive = null;

  UpdateStatusDto();

  @override
  String toString() {
    return 'UpdateStatusDto[id=$id, isActive=$isActive, ]';
  }

  UpdateStatusDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'isActive': isActive};
  }

  static List<UpdateStatusDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UpdateStatusDto>()
        : json.map((value) => new UpdateStatusDto.fromJson(value)).toList();
  }

  static Map<String, UpdateStatusDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdateStatusDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UpdateStatusDto.fromJson(value));
    }
    return map;
  }
}
