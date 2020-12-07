part of swagger.api;

class IPapricaItemModelDto {
  IPapricaItemModelDto();

  @override
  String toString() {
    return 'IPapricaItemModelDto[]';
  }

  IPapricaItemModelDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
  }

  Map<String, dynamic> toJson() {
    return {};
  }

  static List<IPapricaItemModelDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<IPapricaItemModelDto>()
        : json
            .map((value) => new IPapricaItemModelDto.fromJson(value))
            .toList();
  }

  static Map<String, IPapricaItemModelDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, IPapricaItemModelDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new IPapricaItemModelDto.fromJson(value));
    }
    return map;
  }
}
