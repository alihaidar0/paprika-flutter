part of swagger.api;

class PublishedPollInPapricaItem {
  String title = null;

  List<PublishedPollItem> items = [];

  ApiFilterModel filter = null;

  PublishedPollInPapricaItem();

  @override
  String toString() {
    return 'PublishedPollInPapricaItem[title=$title, items=$items, filter=$filter, ]';
  }

  PublishedPollInPapricaItem.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    title = json['title'];
    items = PublishedPollItem.listFromJson(json['items']);
    filter = ApiFilterModel.fromJson(json['filter']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'items': items,
      'filter': filter,
    };
  }

  static List<PublishedPollInPapricaItem> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PublishedPollInPapricaItem>()
        : json.map((value) => new PublishedPollInPapricaItem.fromJson(value)).toList();
  }

  static Map<String, PublishedPollInPapricaItem> mapFromJson(
      Map<String, Map<String, dynamic>> json, int type) {
    var map = new Map<String, PublishedPollInPapricaItem>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new PublishedPollInPapricaItem.fromJson(value));
    }
    return map;
  }
}
