part of swagger.api;

class AuthenticateModel {
  String userNameOrPhoneNumber = null;

  String password = null;

  bool rememberClient = null;

  int scope;

  AuthenticateModel();

  @override
  String toString() {
    return 'AuthenticateModel[userNameOrPhoneNumber=$userNameOrPhoneNumber, password=$password, rememberClient=$rememberClient, scope=$scope,]';
  }

  AuthenticateModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userNameOrPhoneNumber = json['userNameOrPhoneNumber'];
    password = json['password'];
    rememberClient = json['rememberClient'];
    scope = json['scope'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userNameOrPhoneNumber': userNameOrPhoneNumber,
      'password': password,
      'rememberClient': rememberClient,
      'scope': scope,
    };
  }

  static List<AuthenticateModel> listFromJson(List<dynamic> json) {
    return json == null ? new List<AuthenticateModel>() : json.map((value) => new AuthenticateModel.fromJson(value)).toList();
  }

  static Map<String, AuthenticateModel> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AuthenticateModel>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new AuthenticateModel.fromJson(value));
    }
    return map;
  }
}
