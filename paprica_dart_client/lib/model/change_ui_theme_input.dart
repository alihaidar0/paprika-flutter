part of swagger.api;

class ChangeUiThemeInput {
  
  String theme = null;
  
  ChangeUiThemeInput();

  @override
  String toString() {
    return 'ChangeUiThemeInput[theme=$theme, ]';
  }

  ChangeUiThemeInput.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    theme =
        json['theme']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'theme': theme
     };
  }

  static List<ChangeUiThemeInput> listFromJson(List<dynamic> json) {
    return json == null ? new List<ChangeUiThemeInput>() : json.map((value) => new ChangeUiThemeInput.fromJson(value)).toList();
  }

  static Map<String, ChangeUiThemeInput> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ChangeUiThemeInput>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new ChangeUiThemeInput.fromJson(value));
    }
    return map;
  }
}

