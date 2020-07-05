part of swagger.api;

class UpdateActivationStatusDto {
  
  bool isActive = null;
  

  int id = null;
  
  UpdateActivationStatusDto();

  @override
  String toString() {
    return 'UpdateActivationStatusDto[isActive=$isActive, id=$id, ]';
  }

  UpdateActivationStatusDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    isActive =
        json['isActive']
    ;
    id =
        json['id']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'isActive': isActive,
      'id': id
     };
  }

  static List<UpdateActivationStatusDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<UpdateActivationStatusDto>() : json.map((value) => new UpdateActivationStatusDto.fromJson(value)).toList();
  }

  static Map<String, UpdateActivationStatusDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdateActivationStatusDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new UpdateActivationStatusDto.fromJson(value));
    }
    return map;
  }
}

