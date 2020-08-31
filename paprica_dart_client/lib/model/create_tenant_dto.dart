part of swagger.api;

class CreateTenantDto {
  String tenancyName = null;

  String name = null;

  String adminEmailAddress = null;

  String connectionString = null;

  bool isActive = null;

  CreateTenantDto();

  @override
  String toString() {
    return 'CreateTenantDto[tenancyName=$tenancyName, name=$name, adminEmailAddress=$adminEmailAddress, connectionString=$connectionString, isActive=$isActive, ]';
  }

  CreateTenantDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    tenancyName = json['tenancyName'];
    name = json['name'];
    adminEmailAddress = json['adminEmailAddress'];
    connectionString = json['connectionString'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    return {
      'tenancyName': tenancyName,
      'name': name,
      'adminEmailAddress': adminEmailAddress,
      'connectionString': connectionString,
      'isActive': isActive
    };
  }

  static List<CreateTenantDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CreateTenantDto>()
        : json.map((value) => new CreateTenantDto.fromJson(value)).toList();
  }

  static Map<String, CreateTenantDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CreateTenantDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CreateTenantDto.fromJson(value));
    }
    return map;
  }
}
