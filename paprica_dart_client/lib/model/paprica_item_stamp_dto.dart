part of swagger.api;

class PapricaItemStampDto {
  int type = null;

  //enum typeEnum {  1,  2,  3,  4,  };

  int stamp = null;

  PapricaItemStampDto();

  @override
  String toString() {
    return 'PapricaItemStampDto[type=$type, stamp=$stamp, ]';
  }

  PapricaItemStampDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    type = json['type'];
    stamp = json['stamp'];
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'stamp': stamp};
  }

  static List<PapricaItemStampDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PapricaItemStampDto>()
        : json.map((value) => new PapricaItemStampDto.fromJson(value)).toList();
  }

  static Map<String, PapricaItemStampDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PapricaItemStampDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PapricaItemStampDto.fromJson(value));
    }
    return map;
  }
}
