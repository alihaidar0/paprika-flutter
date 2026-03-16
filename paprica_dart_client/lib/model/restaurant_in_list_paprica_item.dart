part of swagger.api;

class RestaurantInListPapricaItem {
  int id = null;

  String name = null;

  double rate = null;

  String logo = null;

  bool isOpen = null;

  RestaurantInListPapricaItem();

  @override
  String toString() {
    return 'RestaurantInListPapricaItem[id=$id, name=$name, rate=$rate, logo=$logo, isOpen=$isOpen, ]';
  }

  RestaurantInListPapricaItem.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    rate = json['rate'];
    logo = json['logo'];
    isOpen = json['isOpen'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'rate': rate,
      'logo': logo,
      'isOpen': isOpen
    };
  }

  static List<RestaurantInListPapricaItem> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<RestaurantInListPapricaItem>()
        : json
            .map((value) => new RestaurantInListPapricaItem.fromJson(value))
            .toList();
  }

  static Map<String, RestaurantInListPapricaItem> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RestaurantInListPapricaItem>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new RestaurantInListPapricaItem.fromJson(value));
    }
    return map;
  }
}
