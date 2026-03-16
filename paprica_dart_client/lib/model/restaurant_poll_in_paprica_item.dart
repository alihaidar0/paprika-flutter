part of swagger.api;

class RestaurantPollInPapricaItem {
  String name = null;

  int votes = null;

  String logoImage = null;

  int id = null;

  RestaurantPollInPapricaItem();

  @override
  String toString() {
    return 'RestaurantPollInPapricaItem[name=$name, votes=$votes, logoImage=$logoImage, id=$id,]';
  }

  RestaurantPollInPapricaItem.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    votes = json['votes'];
    logoImage = json['logoImage'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'votes': votes,
      'logoImage': logoImage,
      'id': id,
    };
  }

  static List<RestaurantPollInPapricaItem> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<RestaurantPollInPapricaItem>()
        : json
        .map((value) => new RestaurantPollInPapricaItem.fromJson(value))
        .toList();
  }

  static Map<String, RestaurantPollInPapricaItem> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RestaurantPollInPapricaItem>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new RestaurantPollInPapricaItem.fromJson(value));
    }
    return map;
  }
}
