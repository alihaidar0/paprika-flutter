part of swagger.api;

class GetCurrentLoginInformationsOutput {
  
  ApplicationInfoDto application = null;
  

  UserLoginInfoDto user = null;
  

  TenantLoginInfoDto tenant = null;
  
  GetCurrentLoginInformationsOutput();

  @override
  String toString() {
    return 'GetCurrentLoginInformationsOutput[application=$application, user=$user, tenant=$tenant, ]';
  }

  GetCurrentLoginInformationsOutput.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    application =
      
      
      new ApplicationInfoDto.fromJson(json['application'])
;
    user =
      
      
      new UserLoginInfoDto.fromJson(json['user'])
;
    tenant =
      
      
      new TenantLoginInfoDto.fromJson(json['tenant'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'application': application,
      'user': user,
      'tenant': tenant
     };
  }

  static List<GetCurrentLoginInformationsOutput> listFromJson(List<dynamic> json) {
    return json == null ? new List<GetCurrentLoginInformationsOutput>() : json.map((value) => new GetCurrentLoginInformationsOutput.fromJson(value)).toList();
  }

  static Map<String, GetCurrentLoginInformationsOutput> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, GetCurrentLoginInformationsOutput>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new GetCurrentLoginInformationsOutput.fromJson(value));
    }
    return map;
  }
}

