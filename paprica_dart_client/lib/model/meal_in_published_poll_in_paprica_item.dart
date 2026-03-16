part of swagger.api;

class MealInPublishedPollInPapricaItem {
  String name = null;

  String thumbnailImage = null;

  double mealRate = null;

  int id = null;

  MealInPublishedPollInPapricaItem();

  @override
  String toString() {
    return 'MealInPublishedPollInPapricaItem[name=$name, thumbnailImage=$thumbnailImage, mealRate=$mealRate, id=$id,]';
  }

  MealInPublishedPollInPapricaItem.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    thumbnailImage = json['thumbnailImage'];
    mealRate = json['mealRate'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'thumbnailImage': thumbnailImage,
      'mealRate': mealRate,
      'id': id,
    };
  }

  static List<MealInPublishedPollInPapricaItem> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<MealInPublishedPollInPapricaItem>()
        : json
        .map((value) => new MealInPublishedPollInPapricaItem.fromJson(value))
        .toList();
  }

  static Map<String, MealInPublishedPollInPapricaItem> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MealInPublishedPollInPapricaItem>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new MealInPublishedPollInPapricaItem.fromJson(value));
    }
    return map;
  }
}
