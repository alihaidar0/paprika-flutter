part of swagger.api;

class OpenPollItem {
  int id = null;

  DateTime closeDate = null;

  String pollText = null;

  List<RestaurantPollInPapricaItem> restaurants = null;

  int totalVotes = null;

  int selectedRestaurant = null;

  OpenPollItem();

  @override
  String toString() {
    return 'OpenPollItems[id=$id, closeDate=$closeDate, pollText=$pollText, restaurants=$restaurants, totalVotes=$totalVotes, selectedRestaurant=$selectedRestaurant, ]';
  }

  OpenPollItem.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    closeDate = json['closeDate'] == null ? null : DateTime.parse(json['closeDate'].toString());
    pollText = json['pollText'];
    restaurants = RestaurantPollInPapricaItem.listFromJson(json['restaurants']);
    totalVotes = json['totalVotes'];
    selectedRestaurant = json['selectedRestaurant'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'closeDate': closeDate == null ? '' : closeDate.toUtc().toIso8601String(),
      'pollText': pollText,
      'restaurants': restaurants,
      'totalVotes': totalVotes,
      'selectedRestaurant': selectedRestaurant,
    };
  }

  static List<OpenPollItem> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<OpenPollItem>()
        : json.map((value) => new OpenPollItem.fromJson(value)).toList();
  }

  static Map<String, OpenPollItem> mapFromJson(
      Map<String, Map<String, dynamic>> json, int type) {
    var map = new Map<String, OpenPollItem>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new OpenPollItem.fromJson(value));
    }
    return map;
  }
}
