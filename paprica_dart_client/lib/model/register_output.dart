part of swagger.api;

class RegisterOutput {
  
  bool canLogin = null;
  
  RegisterOutput();

  @override
  String toString() {
    return 'RegisterOutput[canLogin=$canLogin, ]';
  }

  RegisterOutput.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    canLogin =
        json['canLogin']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'canLogin': canLogin
     };
  }

  static List<RegisterOutput> listFromJson(List<dynamic> json) {
    return json == null ? new List<RegisterOutput>() : json.map((value) => new RegisterOutput.fromJson(value)).toList();
  }

  static Map<String, RegisterOutput> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RegisterOutput>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new RegisterOutput.fromJson(value));
    }
    return map;
  }
}

