part of swagger.api;

class PapricaItemQueryDto {
  List<PapricaItemStampDto> stamps = [];

  PapricaItemQueryDto();

  static PapricaItemQueryDto init() {
    var initDto = PapricaItemQueryDto();
    initDto.stamps = null;
    return initDto;
  }

  @override
  String toString() {
    return 'PapricaItemQueryDto[stamps=$stamps, ]';
  }

  PapricaItemQueryDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    stamps = PapricaItemStampDto.listFromJson(json['stamps']);
  }

  Map<String, dynamic> toJson() {
    return {'stamps': stamps};
  }

  static List<PapricaItemQueryDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PapricaItemQueryDto>()
        : json.map((value) => new PapricaItemQueryDto.fromJson(value)).toList();
  }

  static Map<String, PapricaItemQueryDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PapricaItemQueryDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PapricaItemQueryDto.fromJson(value));
    }
    return map;
  }
}
