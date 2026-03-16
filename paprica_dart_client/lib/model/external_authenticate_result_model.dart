part of swagger.api;

class ExternalAuthenticateResultModel {
  String accessToken = null;

  int expireInSeconds = null;

  String phoneNumber = null;

  bool isPhoneNumberConfirmed = null;

  bool waitingForActivation = null;

  ExternalAuthenticateResultModel();

  @override
  String toString() {
    return 'ExternalAuthenticateResultModel[accessToken=$accessToken, expireInSeconds=$expireInSeconds, waitingForActivation=$waitingForActivation, isPhoneNumberConfirmed=$isPhoneNumberConfirmed, phoneNumber=$phoneNumber ]';
  }

  ExternalAuthenticateResultModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    accessToken = json['accessToken'];
    phoneNumber = json['phoneNumber'];
    isPhoneNumberConfirmed = json['isPhoneNumberConfirmed'];
    expireInSeconds = json['expireInSeconds'];
    waitingForActivation = json['waitingForActivation'];
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'expireInSeconds': expireInSeconds,
      'waitingForActivation': waitingForActivation,
      'phoneNumber': phoneNumber,
      'isPhoneNumberConfirmed': isPhoneNumberConfirmed
    };
  }

  static List<ExternalAuthenticateResultModel> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<ExternalAuthenticateResultModel>()
        : json
            .map((value) => new ExternalAuthenticateResultModel.fromJson(value))
            .toList();
  }

  static Map<String, ExternalAuthenticateResultModel> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ExternalAuthenticateResultModel>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ExternalAuthenticateResultModel.fromJson(value));
    }
    return map;
  }
}
