part of swagger.api;

class AuthenticateResultModel {
  
  String accessToken = null;
  int expireInSeconds = null;
  int userId = null;
  String phoneNumber = null;
  bool isPhoneNumberConfirmed = null;

  AuthenticateResultModel();

  @override
  String toString() {
    return 'AuthenticateResultModel[accessToken=$accessToken, phoneNumber=$phoneNumber, isPhoneNumberConfirmed=$isPhoneNumberConfirmed, expireInSeconds=$expireInSeconds, userId=$userId, ]';
  }

  AuthenticateResultModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    accessToken =
        json['accessToken']
    ;
    phoneNumber =
        json['phoneNumber']
    ;
    isPhoneNumberConfirmed =
      json['isPhoneNumberConfirmed']
    ;
    expireInSeconds =
        json['expireInSeconds']
    ;
    userId =
        json['userId']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'phoneNumber': phoneNumber,
      'isPhoneNumberConfirmed': isPhoneNumberConfirmed,
      'expireInSeconds': expireInSeconds,
      'userId': userId
     };
  }

  static List<AuthenticateResultModel> listFromJson(List<dynamic> json) {
    return json == null ? new List<AuthenticateResultModel>() : json.map((value) => new AuthenticateResultModel.fromJson(value)).toList();
  }

  static Map<String, AuthenticateResultModel> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AuthenticateResultModel>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new AuthenticateResultModel.fromJson(value));
    }
    return map;
  }
}

