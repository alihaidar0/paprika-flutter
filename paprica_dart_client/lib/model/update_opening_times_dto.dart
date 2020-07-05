part of swagger.api;

class UpdateOpeningTimesDto {
  
  List<UpdateOpeningTimeDto> openingTimes = [];
  
  UpdateOpeningTimesDto();

  @override
  String toString() {
    return 'UpdateOpeningTimesDto[openingTimes=$openingTimes, ]';
  }

  UpdateOpeningTimesDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    openingTimes =
      UpdateOpeningTimeDto.listFromJson(json['openingTimes'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'openingTimes': openingTimes
     };
  }

  static List<UpdateOpeningTimesDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<UpdateOpeningTimesDto>() : json.map((value) => new UpdateOpeningTimesDto.fromJson(value)).toList();
  }

  static Map<String, UpdateOpeningTimesDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdateOpeningTimesDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new UpdateOpeningTimesDto.fromJson(value));
    }
    return map;
  }
}

