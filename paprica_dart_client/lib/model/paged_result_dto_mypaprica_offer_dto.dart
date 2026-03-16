part of swagger.api;

class PagedResultDtoMyPapricaOfferDto {
  List<OfferPapricaItemDto> items = [];

  String title = null;

  PagedResultDtoMyPapricaOfferDto();

  @override
  String toString() {
    return 'PagedResultDtoMyPapricaOfferDto[items=$items, ]';
  }

  PagedResultDtoMyPapricaOfferDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    title = json['title'];
    items = OfferPapricaItemDto.listFromJson(json['items']);
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'items': items};
  }

  static List<PagedResultDtoMyPapricaOfferDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<PagedResultDtoMyPapricaOfferDto>()
        : json
            .map((value) => new PagedResultDtoMyPapricaOfferDto.fromJson(value))
            .toList();
  }

  static Map<String, PagedResultDtoMyPapricaOfferDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PagedResultDtoMyPapricaOfferDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PagedResultDtoMyPapricaOfferDto.fromJson(value));
    }
    return map;
  }
}
