part of swagger.api;

class PapricaItemDto {
  int stamp = null;

  int type = null;

  //enum typeEnum {  1 (reservation),  2 (offer),  3 (event),  4 (restaurant), 5 (restaurants), 6 (news)};

  dynamic model = null;

  PapricaItemDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    stamp = json['stamp'];
    type = json['type'];

    switch (type) {
      case 1:
        model = ReservationPapricaItemDto.fromJson(json['model']);
        break;
      case 2:
        model = OfferPapricaItemDto.fromJson(json['model']);
        break;
      case 3:
        model = EventPapricaItemDto.fromJson(json['model']);
        break;
      case 4:
        model = RestaurantSummaryDto.fromJson(json['model']);
        break;
      case 5:
        model = ListPapricaItemDto.fromJson(json['model']);
        break;
      case 7:
        model = PagedResultDtoMyPapricaOfferDto.fromJson(json['model']);
        break;
      case 8:
        model = PublishedPollInPapricaItem.fromJson(json['model']);
        break;
      case 9:
        model = OpenPollInPapricaItem.fromJson(json['model']);
        break;
    }
  }

  PapricaItemDto();

  @override
  String toString() {
    return 'PapricaItemDto[stamp=$stamp, type=$type, model=$model, ]';
  }

  Map<String, dynamic> toJson() {
    return {'stamp': stamp, 'type': type, 'model': model};
  }

  static List<PapricaItemDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PapricaItemDto>()
        : json.map((value) => new PapricaItemDto.fromJson(value)).toList();
  }

  static Map<String, PapricaItemDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PapricaItemDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PapricaItemDto.fromJson(value));
    }
    return map;
  }
}
