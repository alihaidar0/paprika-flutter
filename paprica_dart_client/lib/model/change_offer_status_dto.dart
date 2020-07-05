part of swagger.api;

class ChangeOfferStatusDto {
  
  bool isActive = null;
  

  int id = null;
  
  ChangeOfferStatusDto();

  @override
  String toString() {
    return 'ChangeOfferStatusDto[isActive=$isActive, id=$id, ]';
  }

  ChangeOfferStatusDto.fromJson(Map<String, dynamic> json) {
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

  static List<ChangeOfferStatusDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<ChangeOfferStatusDto>() : json.map((value) => new ChangeOfferStatusDto.fromJson(value)).toList();
  }

  static Map<String, ChangeOfferStatusDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ChangeOfferStatusDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new ChangeOfferStatusDto.fromJson(value));
    }
    return map;
  }
}

