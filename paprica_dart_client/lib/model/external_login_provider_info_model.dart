part of swagger.api;

class ExternalLoginProviderInfoModel {
  
  String name = null;
  

  String clientId = null;
  
  ExternalLoginProviderInfoModel();

  @override
  String toString() {
    return 'ExternalLoginProviderInfoModel[name=$name, clientId=$clientId, ]';
  }

  ExternalLoginProviderInfoModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name =
        json['name']
    ;
    clientId =
        json['clientId']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'clientId': clientId
     };
  }

  static List<ExternalLoginProviderInfoModel> listFromJson(List<dynamic> json) {
    return json == null ? new List<ExternalLoginProviderInfoModel>() : json.map((value) => new ExternalLoginProviderInfoModel.fromJson(value)).toList();
  }

  static Map<String, ExternalLoginProviderInfoModel> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ExternalLoginProviderInfoModel>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new ExternalLoginProviderInfoModel.fromJson(value));
    }
    return map;
  }
}

