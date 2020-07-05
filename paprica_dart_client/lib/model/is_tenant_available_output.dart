part of swagger.api;

class IsTenantAvailableOutput {
  
  int state = null;
  //enum stateEnum {  1,  2,  3,  };

  int tenantId = null;
  
  IsTenantAvailableOutput();

  @override
  String toString() {
    return 'IsTenantAvailableOutput[state=$state, tenantId=$tenantId, ]';
  }

  IsTenantAvailableOutput.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    state =
        json['state']
    ;
    tenantId =
        json['tenantId']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'state': state,
      'tenantId': tenantId
     };
  }

  static List<IsTenantAvailableOutput> listFromJson(List<dynamic> json) {
    return json == null ? new List<IsTenantAvailableOutput>() : json.map((value) => new IsTenantAvailableOutput.fromJson(value)).toList();
  }

  static Map<String, IsTenantAvailableOutput> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, IsTenantAvailableOutput>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new IsTenantAvailableOutput.fromJson(value));
    }
    return map;
  }
}

