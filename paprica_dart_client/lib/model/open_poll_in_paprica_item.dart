part of swagger.api;

class OpenPollInPapricaItem {
  String title = null;

  List<OpenPollItem> items = null;

  ApiFilterModel filter = null;

  OpenPollInPapricaItem();

  @override
  String toString() {
    return 'OpenPollInPapricaItem[title=$title, items=$items, filter=$filter, ]';
  }

  OpenPollInPapricaItem.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    title = json['title'];
    items = OpenPollItem.listFromJson(json['items']);
    filter = ApiFilterModel.fromJson(json['filter']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'items': items,
      'filter': filter,
    };
  }

  static List<OpenPollInPapricaItem> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<OpenPollInPapricaItem>()
        : json.map((value) => new OpenPollInPapricaItem.fromJson(value)).toList();
  }

  static Map<String, OpenPollInPapricaItem> mapFromJson(
      Map<String, Map<String, dynamic>> json, int type) {
    var map = new Map<String, OpenPollInPapricaItem>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new OpenPollInPapricaItem.fromJson(value));
    }
    return map;
  }
}
