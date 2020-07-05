part of swagger.api;

class IsTenantAvailableInput {
  
  String tenancyName = null;
  
  IsTenantAvailableInput();

  @override
  String toString() {
    return 'IsTenantAvailableInput[tenancyName=$tenancyName, ]';
  }

  IsTenantAvailableInput.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    tenancyName =
        json['tenancyName']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'tenancyName': tenancyName
     };
  }

  static List<IsTenantAvailableInput> listFromJson(List<dynamic> json) {
    return json == null ? new List<IsTenantAvailableInput>() : json.map((value) => new IsTenantAvailableInput.fromJson(value)).toList();
  }

  static Map<String, IsTenantAvailableInput> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, IsTenantAvailableInput>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new IsTenantAvailableInput.fromJson(value));
    }
    return map;
  }
}

