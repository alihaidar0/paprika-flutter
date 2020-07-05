part of swagger.api;

class PapricaItemsDto {
  List<PapricaItemDto> papricaItems = [];

  PapricaItemsDto();

  @override
  String toString() {
    return 'PapricaItemsDto[papricaItems=$papricaItems, ]';
  }

  PapricaItemsDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    papricaItems = PapricaItemDto.listFromJson(json['papricaItems']);
  }

  Map<String, dynamic> toJson() {
    return {'papricaItems': papricaItems};
  }

  static List<PapricaItemsDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PapricaItemsDto>()
        : json.map((value) => new PapricaItemsDto.fromJson(value)).toList();
  }

  static Map<String, PapricaItemsDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PapricaItemsDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PapricaItemsDto.fromJson(value));
    }
    return map;
  }
}
