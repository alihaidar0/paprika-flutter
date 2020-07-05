part of swagger.api;

class ListPapricaItemDto {
  String title = null;

  List<RestaurantInListPapricaItem> items = null;

  ApiFilterModel filter = null;

  ListPapricaItemDto();

  @override
  String toString() {
    return 'ListPapricaItemDto[title=$title, items=$items, filter=$filter, ]';
  }

  ListPapricaItemDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    title = json['title'];
//    if (type == 5) items = RestaurantInListPapricaItem.listFromJson(json['items']);
    items = RestaurantInListPapricaItem.listFromJson(json['items']);
    filter = ApiFilterModel.fromJson(json['filter']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'items': items,
      'filter': filter,
    };
  }

  static List<ListPapricaItemDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ListPapricaItemDto>()
        : json.map((value) => new ListPapricaItemDto.fromJson(value)).toList();
  }

  static Map<String, ListPapricaItemDto> mapFromJson(
      Map<String, Map<String, dynamic>> json, int type) {
    var map = new Map<String, ListPapricaItemDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ListPapricaItemDto.fromJson(value));
    }
    return map;
  }
}
