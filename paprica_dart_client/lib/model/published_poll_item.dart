part of swagger.api;

class PublishedPollItem {
  int id = null;

  String resaultText = null;

  RestaurantPollInPapricaItem restaurant = null;

  MealInPublishedPollInPapricaItem meal = null;

  int totalVotes = null;

  PublishedPollItem();

  @override
  String toString() {
    return 'PublishedPollItem[id=$id, resaultText=$resaultText, restaurant=$restaurant, meal=$meal, totalVotes=$totalVotes, ]';
  }

  PublishedPollItem.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    resaultText = json['resaultText'];
    restaurant = RestaurantPollInPapricaItem.fromJson(json['restaurant']);
    meal = MealInPublishedPollInPapricaItem.fromJson(json['meal']);
    totalVotes = json['totalVotes'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'resaultText': resaultText,
      'restaurant': restaurant,
      'meal': meal,
      'totalVotes': totalVotes,
    };
  }

  static List<PublishedPollItem> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PublishedPollItem>()
        : json.map((value) => new PublishedPollItem.fromJson(value)).toList();
  }

  static Map<String, PublishedPollItem> mapFromJson(
      Map<String, Map<String, dynamic>> json, int type) {
    var map = new Map<String, PublishedPollItem>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new PublishedPollItem.fromJson(value));
    }
    return map;
  }
}
