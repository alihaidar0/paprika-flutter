part of swagger.api;

class ChangeFreeSpaceIndicator {
  
  bool hasFreeSpace = null;
  
  ChangeFreeSpaceIndicator();

  @override
  String toString() {
    return 'ChangeFreeSpaceIndicator[hasFreeSpace=$hasFreeSpace, ]';
  }

  ChangeFreeSpaceIndicator.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    hasFreeSpace =
        json['hasFreeSpace']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'hasFreeSpace': hasFreeSpace
     };
  }

  static List<ChangeFreeSpaceIndicator> listFromJson(List<dynamic> json) {
    return json == null ? new List<ChangeFreeSpaceIndicator>() : json.map((value) => new ChangeFreeSpaceIndicator.fromJson(value)).toList();
  }

  static Map<String, ChangeFreeSpaceIndicator> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ChangeFreeSpaceIndicator>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new ChangeFreeSpaceIndicator.fromJson(value));
    }
    return map;
  }
}

